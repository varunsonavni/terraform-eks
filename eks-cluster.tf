module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.21.0"
  cluster_name    = "${var.cluster_name}-${var.env}"
  cluster_version = "${var.cluster_version}"
  subnet_ids         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    # root_volume_size = var.root_volume_size
    root_volume_type = var.root_volume_type
  }


  eks_managed_node_groups = [
    {
      launch_template_name          = "${var.launch_template_name}-${var.env}"
      name                          = "${var.worker_group_name}-1"
      instance_type                 = "${var.worker_instance}"
      additional_userdata           = "${file("user_data.sh")}"
      key_name                      = var.key_name
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = var.worker_desired_capacity
      asg_min_size                  = var.asg_min_size
      asg_max_size                  = var.asg_max_size
    },
    {
      launch_template_name = "${var.launch_template_name}"
      name                          = "${var.worker_group_name}-2"
      instance_type                 = "${var.worker_instance}"
      additional_userdata           = "${file("user_data.sh")}"
      key_name                      = var.key_name
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = var.worker_desired_capacity
      asg_min_size                  = var.asg_min_size
      asg_max_size                  = var.asg_max_size
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
