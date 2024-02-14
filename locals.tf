locals {
  sufix = "${var.tags.project}-${var.tags.env}-${var.tags.region}" # Sufijo para los recursos proyecto_region
}

resource "random_string" "bucket_sufix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  bucket_sufix = "${var.tags.project}-${random_string.bucket_sufix.id}"
}