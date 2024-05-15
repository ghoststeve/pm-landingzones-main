# PM LandingZones Repository

This repo contains general Azure Platform code which is for resources that
aren't specific to a particular project and are intended to be shared between
projects.

## Usage

Similar to the other repos, resources to be deployed are defined within the
[manifests](manifests/) directory and any Terraform modules being referenced
can be found in the [TF Libraries repo](https://github.com/BritishAirways-Ent/bcup-glb-tf-libraries).  
The manifests themselves are divided into `levels` which are based on the approach
defined in the Azure Terraform SRE guide found [here](https://aztfmod.github.io/documentation/docs/fundamentals/lz-intro/).

The configuration for which manifests are deployed and to where can be found within the
config.yml file found in the root of the repo, and the setting of any environment specific
config through variables is done within the relevant [environments](environments/) directory.
