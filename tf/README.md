## Setup ##

- Install [OpenTofu](https://opentofu.org/docs/intro/install/)
- Create a DigitalOcean [Personal Access Token (PAT)](https://docs.digitalocean.com/reference/api/create-personal-access-token/)
- Set [variables](./variables.tf)

Then run:

```sh
tofu init
```

(Optional)
```sh
tofu plan
```

```sh
tofu apply
```
