data "aws_availability_zones" "available" {}

locals {
  cluster_name = "demo-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}
module "network" {
  source = "./modules/network"

  vpc_cidr_block             = "10.0.0.0/16"
  vpc_tag_name               = "${local.cluster_name}-vpc"
  availability_zones         = ["us-east-1a", "us-east-1b"]
  route_table_tag_name       = "${local.cluster_name}-route-table"
  private_subnet_tag_name    = "${local.cluster_name}-private-subnet"
  private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidr_blocks  = ["10.0.3.0/24", "10.0.4.0/24"]
  public_subnet_tag_name     = "${local.cluster_name}-public-subnet"
  eks_cluster_name           = local.cluster_name
}

module "eks" {
  source = "./modules/eks"

  eks_cluster_name        = local.cluster_name
  node_group_name         = "${local.cluster_name}-ng"
  endpoint_private_access = true
  endpoint_public_access  = true
  eks_cluster_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids      = module.network.private_subnet_ids
  public_subnet_ids       = module.network.public_subnet_ids
  ami_type                = "AL2_x86_64"
  disk_size               = 20
  instance_types          = ["t3.medium"]
  pvt_desired_size        = 1
  pvt_max_size            = 2
  pvt_min_size            = 1
  pblc_desired_size       = 1
  pblc_max_size           = 1
  pblc_min_size           = 1
  cluster_sg_name         = "${local.cluster_name}-sg"
  nodes_sg_name           = "${local.cluster_name}-nodes-sg"
  vpc_id                  = module.network.vpc_id
}

module "nginx" {
  source = "./modules/nginx"

  depends_on = [ module.eks ]
}