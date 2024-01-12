output "cluster_endpoint" {
  value = aws_eks_cluster.main.endpoint
}
output "cluster_security_group_id" {
  value = aws_security_group.eks_cluster.id
}
output "cluster_name" {
  value = aws_eks_cluster.main.name
}
output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.main.certificate_authority.0.data
}