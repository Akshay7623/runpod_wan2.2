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
# OPTIMIZED CUDA 12.6 MINIMAL BASE SETTINGS
# ==========================================
variable "BASE_IMAGE" {
  default = "nvidia/cuda:12.6.3-base-ubuntu24.04"
}

# Leave this blank so the default installer does not conflict
variable "CUDA_VERSION_FOR_COMFY" {
  default = ""
}

# Force the upgrade to get the latest FP8 kernels
variable "ENABLE_PYTORCH_UPGRADE" {
  default = "true"
}

# Pull the highly optimized CUDA 12.4 PyTorch wheels
variable "PYTORCH_INDEX_URL" {
  default = "https://download.pytorch.org/whl/cu128"
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
  }
  # Updated the tag to reflect the CUDA 12.4 PyTorch wheels
  tags = ["${DOCKERHUB_REPO}/${DOCKERHUB_IMG}:${RELEASE_VERSION}-base-cu124"]
}