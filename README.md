<h1 align="center">Welcome to EKS Setup Example with Terraform 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-v0-blue.svg?cacheSeconds=2592000" />
  <a href="/" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
  <a href="https://twitter.com/fidelissauro" target="_blank">
    <img alt="Twitter: fidelissauro" src="https://img.shields.io/twitter/follow/fidelissauro.svg?style=social" />
  </a>
</p>

> :package: :whale: :rocket: Easy Way to Setup EKS with Ingress Controller like Nginx, Traefik, Envoy e etc :rocket: :whale: :package: 

This repo contains methods to deploy this resources on Amazon EKS 

* Custom Ingress Controller behind the ALB to save :money: 

* Jaeger to improve observability 

* Deployment methods for infraestructure and applications

Enjoy and customize to your use case :happy: 


### 🏠 [Homepage](/)

### ✨ [Demo](/)

## Install

```sh
git clone git@github.com:msfidelis/eks-terraform-setup.git
```

## Usage

This repo should be used like template or reference to your project.

### Edit variables.tf

```sh
vim variables.tf
```

### Apply 

```sh
terraform plan
terraform install --auto-approve
```

## Run tests

```sh
terraform validate
```

## Author

👤 **Matheus Fidelis**

* Website: https://raj.ninja
* Twitter: [@fidelissauro](https://twitter.com/fidelissauro)
* Github: [@msfidelis](https://github.com/msfidelis)
* LinkedIn: [@msfidelis](https://linkedin.com/in/msfidelis)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](/issues). You can also take a look at the [contributing guide](CONTRIBUTING.md).

## Show your support

Give a ⭐️ if this project helped you!

## 📝 License

Copyright © 2020 [Matheus Fidelis](https://github.com/msfidelis).<br />
This project is [MIT](LICENSE) licensed.

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_