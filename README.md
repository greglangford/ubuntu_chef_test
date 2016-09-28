# Bootstrap Ubuntu Node Using Chef Zero and Supplied Recipes

1. To run this against a remote node you must have access to root over SSH (it works best if you have a passwordless ssh key setup otherwise be prepared to enter passwords)
2. From a linux terminal run ./bootstrap.sh <IP ADDRESS> e.g ./bootstrap.sh 1.1.1.1
3. Wait for the bootstrap process to finish, you will be presented with the output of uptime from the server.

You may also test this using Vagrant and Test Kitchen, you will need Virtual Box, Vagrant and Chef Development Kit installed.
1. Run kitchen init from repo root
2. Run kitchen converge from the repo root and watch the automation magic

## Notes
Usually I would not use root over SSH access, however this has been done for the sake of simplicity.
Without root we would require that the user have passwordless sudo access and sudo should also be able to run without a TTY

To further enhance this I would put some timeout conditions in the while loops, otherwise if this were run from CI the job
will become hung, unless the CI implements its own time out for long running jobs.

Chef would work best using the Chef Server and Node architecture, this way knife bootstrap could be used and allows us to define
the roles, recipes and associated environment of the node. By doing so also ensures compliance as on each chef run if any chef
manage resources have changed, they will be converged back to the defined resource.
