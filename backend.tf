terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "ap-southeast-2"
    profile = "terraformUser"
    key     = "terraformstatefile"
    bucket  = "ggburtonhasaterraformbucket"
  }
}
