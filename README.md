## jenkins-dockerhost

jenkins-dockerhost is an Ubuntu machine containing a number of docker services.

See http://jenkins-dockerhost

The machine contains:

- A number of services
- A Jenkins Continuous Integration server able to rebuild and deploy each service and itself.

## Procedure adding a service
- Create the server in a source code repository available from Jenkins
- Add a new entry in jenkins-dockerhost/nginx/index.html
- Add a new entry in jenkins-dockerhost/nginx/conf.d/default.conf
- Add a new Jenkins-job to build and deploy the service
- Run the Jenkins job
- Verify that the service is working using for example postman on the designated URL, for example http://jenkins-dockerhost/service-1/greeting

[Ubuntu installation instructions](ubuntu-install.md)
[Jenkins setup](jenkins-setup.md)
