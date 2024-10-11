just := env_var_or_default("JUST", just_executable())

wash := env_var_or_default("WASH", "wash")
wit_deps := env_var_or_default("WIT_DEPS", "wit-deps")

@default:
    {{just}} --list

# Build all subprojects
build: build-component build-provider

# Build the component
@build-component:    
    cd component-http-hello && {{wit_deps}} update
    {{wash}} build -p component-http-hello/wasmcloud.toml

# Build the provider
@build-provider:    
    {{wash}} build -p provider-custom/wasmcloud.toml

# Deploy the WADM manifest
@deploy:
    {{wash}} build -p component-http-hello/wasmcloud.toml
    {{wash}} build -p provider-custom/wasmcloud.toml

# Set up the environment to reproduce the bug
@setup:
    echo "[info] starting a new (detached) wasmCloud instance..."
    {{wash}} up -d
    echo "[info] deploying the reproduction WADM manifest..."
    {{wash}} app deploy repro.wadm.yaml

# Set up the environment to reproduce the bug
@teardown:
    echo "[info] removing repro app..."
    {{wash}} app delete repro.wadm.yaml
    sleep 5
    echo "[info] stopping all running wasmCloud instances..."
    {{wash}} down --all
