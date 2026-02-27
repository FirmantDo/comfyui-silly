variable "TAG" {
  default = "slim"
}

group "default" {
  targets = ["common", "dev"]
}

# Common settings for all targets
target "common" {
  context = "."
  platforms = ["linux/amd64"]
}

# Regular ComfyUI image (CUDA 12.4)
target "regular" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = [
    "demogest/comfyui-silly:${TAG}",
    "demogest/comfyui-silly:latest",
  ]
}

# Dev image for local testing
target "dev" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["demogest/comfyui-silly:dev"]
  output = ["type=docker"]
}

# Dev push targets (for CI pushing dev tags, without overriding latest)
target "devpush" {
  inherits = ["common"]
  dockerfile = "Dockerfile"
  tags = ["demogest/comfyui-silly:dev"]
}

target "devpush5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = ["demogest/comfyui-silly:dev-5090"]
}

# RTX 5090 optimized image (CUDA 12.8 + latest PyTorch build)
target "rtx5090" {
  inherits = ["common"]
  dockerfile = "Dockerfile.5090"
  tags = [
    "demogest/comfyui-silly:${TAG}-5090",
    "demogest/comfyui-silly:latest-5090",
  ]
}
