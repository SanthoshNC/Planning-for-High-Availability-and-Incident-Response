# Infrastructure

## AWS Zones
Identify your zones here

The resources will be deployed in the below mentioned zones:

us-west-1 (N.California)
us-east-2 (Ohio)

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| EC2 Instance | To host the website | t3.micro | 3 | Yes |
| SSH Keys | For administering the EC2 instances | N/A | 1 | Yes |
| GitHub repo | for storing the Terraform code | N/A | 1 | N/A |
| EKS | To manage the monitoring applications / other applications | N/A | 2 | Yes |
| EKS - Node Group | To manage the nodes for EKS | t3.medium | 2 to 5 | Yes |
| VPC  | To create the network for the resources | N/A | Based on the AZs | Yes |
| ALB | To load balance the website | N/A | 1 per region | N/A |
| RDS | Backend database running on Amazon RDS nodes for the website | db.t3.micro | 2 | Yes |

### Descriptions

EC2 instances are used to host the website and the instances are based out of the Ubuntu AMI. This AMI will change based on the region. 3 ingress and 1 egress entries will be created in security group for the public access.

SSH key should be generated for the above mentioned EC2 instances for the administration access. The key will be based out of the region.

A GitHub repo will be used to store the Terraform code to deploy the resources in multiple zones.

EKS cluster will be used to host the monitoring applications / other applications. And the cluster should have atleast 2 nodes. And those nodes will be created via the Node Group in order to maintain HA

VPC is used to provide the network to the resources and by default it will be managed by AWS. In addition to this, public and private subnets will be created. This will provide the public and private IP spaces.

ALB is used to manage the load balancing for the website and the ALB is maintained by the AWS itself. The ALB will be associated with the 3 EC2 instances where the website is being hosted.

RDS is used as the backend database for the website to store the data. And there wil be 2 DBs. One will act as the primary and another one will act as the secondary

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

1. Terraform code(IaC) should be ready in prior similar to the current region.
2. The same code should be executed in the another region with the necessary modifications.
3. Both the sites should be in the working or live state.

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

1. The infrastructure should be verified before implementing the changes.
2. The DNS record should be changed to point to the ALB of secondary region. This will make the customer to access the webapp in the secondary region.
3. For the database replication, we can do either of the below mentioned steps:
   1. Manual change in the console to make the DB in secondary region as the primary DB.
   2. Or by using the health checks to automatically failover the primary DB to secondary BD.