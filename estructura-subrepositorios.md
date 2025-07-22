# Estructura con Subrepositorios Independientes

## Opción A: Repositorios separados por módulo
```
tf-modules-s3/
├── .git/
├── main.tf
├── variables.tf
└── outputs.tf

tf-modules-apigateway/
├── .git/
├── main.tf
├── variables.tf
└── outputs.tf

tf-modules-lambda/
├── .git/
├── main.tf
├── variables.tf
└── outputs.tf
```

## Uso en tu proyecto:
```hcl
module "s3_bucket" {
  source = "git@github.com:sijnal/tf-modules-s3.git?ref=main"
  bucket_name = "mi-bucket-simple-sijnal"
}

module "api_gateway" {
  source = "git@github.com:sijnal/tf-modules-apigateway.git?ref=main"
  api_name = "mi-api-gateway"
}
```

## Opción B: Submódulos Git con .git separados
```
tf-modules/
├── .git/                    # Repo principal
├── aws/
│   ├── s3/
│   │   ├── .git/           # Subrepo independiente
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── apigateway/
│   │   ├── .git/           # Subrepo independiente
│   │   ├── main.tf
│   │   └── variables.tf
│   └── lambda/
│       ├── .git/           # Subrepo independiente
│       ├── main.tf
│       └── variables.tf
└── README.md
```

## Ventajas de subrepositorios:
✅ Cada módulo se descarga independientemente
✅ Control de versiones granular
✅ Equipos pueden trabajar en módulos específicos
✅ CI/CD más rápido para módulos individuales

## Desventajas:
❌ Más repositorios para mantener
❌ Posible duplicación de código común
❌ Más complejo de gestionar 