{inputs}:
inputs.haumea.lib.load {
  src = "${inputs.self}/presets";
  loader = inputs.haumea.lib.loaders.path;
}
