variable "DOCKERHUB_REPO" {
  default = "runpod"
}

variable "DOCKERHUB_IMG" {
  default = "worker-comfyui"
}

variable "RELEASE_VERSION" {
  default = "latest"
}

variable "COMFYUI_VERSION" {
  default = "latest"
}

# ==========================================
# OPTIMIZED CUDA 13.0 MINIMAL BASE SETTINGS
# ==========================================
variable "BASE_IMAGE" {
  default = "nvidia/cuda:13.0.0-base-ubuntu24.04"
}

variable "CUDA_VERSION_FOR_COMFY" {
  default = ""
}

variable "ENABLE_PYTORCH_UPGRADE" {
  default = "true"
}

variable "PYTORCH_INDEX_URL" {
  default = "https://download.pytorch.org/whl/cu130"
}

variable "HUGGINGFACE_ACCESS_TOKEN" {
  default = ""
}

# Restrict default build to the base image only
group "default" {
  targets = ["base"]
}

# The only target required for your network volume architecture
target "base" {
  context = "."
  dockerfile = "Dockerfile"
  target = "base"
  platforms = ["linux/amd64"]
  args = {
    BASE_IMAGE = "${BASE_IMAGE}"
    COMFYUI_VERSION = "${COMFYUI_VERSION}"
    CUDA_VERSION_FOR_COMFY = "${CUDA_VERSION_FOR_COMFY}"
    ENABLE_PYTORCH_UPGRADE = "${ENABLE_PYTORCH_UPGRADE}"
    PYTORCH_INDEX_URL = "${PYTORCH_INDEX_URL}"
    # The MODEL_TYPE argument has been successfully removed from here
  }
  tags = ["${DOCKERHUB_REPO}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-base-cu130"]
}