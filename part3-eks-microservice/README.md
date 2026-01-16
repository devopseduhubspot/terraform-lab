
# Part 3 Cleanup (Critical to Avoid AWS Bills)

Steps:

1. Delete Kubernetes resources:
```
kubectl delete -f k8s-deploy.yaml
```

2. Destroy all AWS infrastructure:
```
terraform destroy
```

This removes:
- EKS Cluster
- Worker nodes
- VPC
- Subnets
- NAT Gateway
- Load Balancer
- Everything created by Terraform
