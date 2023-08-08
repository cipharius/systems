{-# LANGUAGE NamedFieldPuns #-}

import XMonad
import Graphics.X11.ExtraTypes.XF86
import qualified Data.Map                           as Map
import qualified XMonad.Actions.DynamicProjects     as DProj
import qualified XMonad.Actions.DynamicWorkspaces   as DWs
import qualified XMonad.Actions.Navigation2D        as Nav2D
import qualified XMonad.Actions.Submap              as SubM
import qualified XMonad.Actions.Warp                as Warp
import qualified XMonad.Hooks.DynamicLog            as DLog
import qualified XMonad.Hooks.EwmhDesktops          as Ewmh
import qualified XMonad.Hooks.ManageDocks           as MDock
import qualified XMonad.Layout.BinarySpacePartition as BSP
import qualified XMonad.Layout.Fullscreen           as Full
import qualified XMonad.Layout.NoBorders            as NoB
import qualified XMonad.Prompt                      as Prompt
import qualified XMonad.Prompt.FuzzyMatch           as PFuzzy
import qualified XMonad.Prompt.Man                  as PMan
import qualified XMonad.Prompt.Shell                as PShell
import qualified XMonad.Prompt.Window               as PWin
import qualified XMonad.StackSet                    as WS
import qualified XMonad.Util.EZConfig               as EZ
import qualified XMonad.Util.Scratchpad             as Scratch
import qualified XMonad.Util.Types                  as Dir
import qualified XMonad.Hooks.SetWMName             as WMName


-- / Entry point / --
main = myXmobar myConfig >>= xmonad
    . DProj.dynamicProjects []
    . Full.fullscreenSupport
    . myNavigation
    . Ewmh.ewmh

-- / XMonad config / --
myConfig = def
    { manageHook      = myManageHook <+> manageHook def
    , startupHook     = return () >> EZ.checkKeymap myConfig myKeys >> WMName.setWMName "LG3D"
    , borderWidth     = 1
    , layoutHook      = myLayout
    , terminal        = myTerminal
    , keys            = (flip EZ.mkKeymap myKeys) <+> keys def
    , modMask         = mod4Mask -- Use Windows key as XMonad modifier
    , handleEventHook = myHandleEventHook <+> handleEventHook def
    }

myLayout
  = MDock.avoidStruts
  $ NoB.smartBorders
  $ Full.fullscreenFull
  $ BSP.emptyBSP

myTerminal = "kitty"

myBrowser = "qutebrowser"

myManageHook = Full.fullscreenManageHook <+> MDock.manageDocks <+> manageScratchpad

myHandleEventHook = Full.fullscreenEventHook

manageScratchpad = Scratch.scratchpadManageHook (WS.RationalRect 0 0.8 1 0.2)

myNavigation = Nav2D.navigation2D def
    (xK_k, xK_h, xK_j, xK_l)
    [ (mod4Mask,               Nav2D.windowGo  )
    , (mod4Mask .|. shiftMask, Nav2D.windowSwap) ]
    False

myXmobar = DLog.statusBar "xmobar" xmobarPP' toggleStrutsKey
    where
        toggleStrutsKey XConfig{modMask = modm} = (modm, xK_b)
        xmobarPP' = def
            { DLog.ppCurrent = DLog.xmobarColor "#f0dfaf" "" . DLog.wrap "[" "]"
            , DLog.ppVisible = DLog.wrap "(" ")"
            , DLog.ppUrgent  = DLog.xmobarColor "red" "yellow"
            , DLog.ppSep     = " | "
            }

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myPrompt :: Prompt.XPConfig
myPrompt = def
    { Prompt.font            = "xft:DejaVu Sans Mono-11"
    , Prompt.position        = Prompt.Top
    , Prompt.searchPredicate = PFuzzy.fuzzyMatch
    , Prompt.sorter          = PFuzzy.fuzzySort }

-- / Key bindings / --
myKeys = let leader = "M-<Space>" in
    [ ("<Print>",                 spawn "screenshot")
    , ("M-`",                     Scratch.scratchpadSpawnActionTerminal myTerminal)
    , ("M-c",                     spawn "xclip -o | xclip -sel clip -i")
    , ("M-;",                     sendMessage $ BSP.Swap)
    , ("M-S-;",                   sendMessage $ BSP.Rotate)
    , ("M-C-l",                   sendMessage $ BSP.MoveSplit Nav2D.R)
    , ("M-C-h",                   sendMessage $ BSP.MoveSplit Nav2D.L)
    , ("M-C-j",                   sendMessage $ BSP.MoveSplit Nav2D.D)
    , ("M-C-k",                   sendMessage $ BSP.MoveSplit Nav2D.U)
    , ("M-,",                     sendMessage $ BSP.SplitShift Dir.Prev)
    , ("M-.",                     sendMessage $ BSP.SplitShift Dir.Next)
    , ("M-o",                     sendMessage $ BSP.FocusParent)
    , ("M-=",                     sendMessage $ BSP.Equalize)
    , ("M-S-=",                   sendMessage $ BSP.Balance)

    -- Media keys --
    , ("<XF86MonBrightnessUp>",   spawn "light -A 10")
    , ("<XF86MonBrightnessDown>", spawn "light -U 10")
    , ("<XF86AudioPlay>",         spawn "playerctl play-pause")
    , ("<XF86AudioPrev>",         spawn "playerctl previous")
    , ("<XF86AudioNext>",         spawn "playerctl next")
    , ("<XF86AudioMute>",         spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioMicMute>",      spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    , ("<XF86AudioRaiseVolume>",  spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioLowerVolume>",  spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")

    -- Leader map --
    , ("M-<Space> <Space>",       PShell.shellPrompt myPrompt)

    , (leader<>" a b",            spawn myBrowser)
    , (leader<>" a t",            spawn myTerminal)
    , (leader<>" a e",            spawn $ myTerminal <> " kak")
    , (leader<>" a m",            spawn "spotify")

    , (leader<>" l l",            DWs.selectWorkspace myPrompt)
    , (leader<>" l L",            DWs.addWorkspacePrompt myPrompt)
    , (leader<>" l r",            DWs.renameWorkspace myPrompt)
    , (leader<>" l d",            DWs.removeWorkspace)

    , (leader<>" w w",            PWin.windowPrompt myPrompt PWin.Goto PWin.allWindows)
    , (leader<>" w S-w",          PWin.windowPrompt myPrompt PWin.Bring PWin.allWindows)
    , (leader<>" w s",            DWs.withWorkspace myPrompt (windows . WS.shift))
    , (leader<>" w p",            DProj.shiftToProjectPrompt myPrompt)

    , (leader<>" m b",            Warp.banishScreen Warp.LowerRight)
    , (leader<>" m m",            Warp.warpToWindow 0.5 0.5)

    , (leader<>" p p",            DProj.switchProjectPrompt myPrompt)
    , (leader<>" p r",            DProj.renameProjectPrompt myPrompt)
    , (leader<>" p d",            DProj.changeProjectDirPrompt myPrompt)

    , (leader<>" h m",            PMan.manPrompt myPrompt)
    ]
