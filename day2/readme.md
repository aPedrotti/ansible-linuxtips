# LinuxTips Training ~ Ansible

## Project Steps
```
- Provisioning
  - Deploy VMs
  
- Install = K8s configuration
  - Install K8s ~ docker and kube binaries
  - Create Cluster ~ Configure environment and init cluster
  - Join Workers ~ Add Nodes to Cluster
  - Helm Install ~ At master to control charts
  - Monitoring ~ Add Prometheus to view cluster;
    - Edit Grafana Service from ClusterIP to NodePort (kubectl get services / kubectl edit service <tool_name-grafana> )
    - Get Node Port of this service, add to Security Group to try accessing it externally through node-public-ip
    - Get Grafana admin password: kubectl get secret prometheus-community-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

- Deploy App
- Extra
```

### Running a Playbook
ansible-playbook -i hosts main.yml
### Getting all Jobs
ansible-playbook -i hosts main.yml --list-tags 
### Getting tasks from a Tag / Job
ansible-playbook -i hosts main.yml --tags <tag_name>,<tag_name2>, --list-tasks


## Ansible + AWS

https://www.ansible.com/integrations/cloud/amazon-web-services

https://docs.ansible.com/ansible/latest/scenario_guides/guide_aws.html

https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html

https://docs.ansible.com/ansible/latest/modules/list_of_cloud_modules.html

https://docs.ansible.com/ansible/latest/modules/ec2_module.html

https://docs.ansible.com/ansible/latest/modules/ec2_group_module.html

https://galaxy.ansible.com/docs/contributing/creating_role.html