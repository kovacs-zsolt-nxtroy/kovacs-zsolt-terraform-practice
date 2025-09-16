# HelloTerra - Azure Container App

Ez a Terraform projekt egy Azure Container App-ot hoz létre egy egyszerű "Hello World" alkalmazással.

## Előfeltételek

1. **Azure CLI** telepítve és konfigurálva
2. **Terraform** telepítve (verzió >= 1.0)
3. **Azure-előfizetés** és megfelelő jogosultságok

## Telepítés

### 1. Azure bejelentkezés

```bash
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

### 2. Konfiguráció

```bash
# Másold át a példa konfigurációt
cp terraform.tfvars.example terraform.tfvars

# Szerkeszd a terraform.tfvars fájlt a saját értékeiddel
nano terraform.tfvars
```

### 3. Terraform inicializálás

```bash
terraform init
```

### 4. Terv ellenőrzése

```bash
terraform plan
```

### 5. Telepítés

```bash
terraform apply
```

### 6. Alkalmazás elérése

A telepítés után a Container App URL-jét a kimenetekben találod:

```bash
terraform output container_app_url
```

## Key Vault integráció

Ha Key Vault-ot szeretnél használni titkos kulcsok kezeléséhez:

1. **Key Vault létrehozása** (ha még nincs):
   ```bash
   az keyvault create --name "your-keyvault-name" --resource-group "your-rg"
   ```

2. **Titkos kulcsok hozzáadása**:
   ```bash
   az keyvault secret set --vault-name "your-keyvault-name" --name "ALMA" --value "your-secret-value"
   ```

3. **Container App hozzáférés engedélyezése**:
   ```bash
   # Key Vault hozzáférési szabályzat hozzáadása
   az keyvault set-policy --name "your-keyvault-name" --object-id $(az ad signed-in-user show --query id -o tsv) --secret-permissions get list
   ```

4. **terraform.tfvars konfigurálása**:
   ```hcl
   key_vault_name = "your-keyvault-name"
   key_vault_resource_group_name = "your-rg"
   
   container_secrets = {
     secret-name = "https://your-keyvault-name.vault.azure.net/secrets/ALMA"
   }
   ```

## Konfigurálható paraméterek

### Alapvető konfiguráció
- `resource_group_name`: Meglévő Azure Resource Group neve
- `location`: Azure régió
- `project_name`: Projekt neve (erőforrások nevezéséhez)

### Container App konfiguráció
- `container_app_environment_name`: Meglévő Container App Environment neve (üresen hagyva új létrehozásához)
- `container_app_name`: Container App neve (üresen hagyva a project_name használatához)
- `log_analytics_workspace_name`: Log Analytics Workspace neve (üresen hagyva a project_name-logs használatához)

### Container beállítások
- `container_image`: Container image URL
- `target_port`: Container port
- `min_replicas` / `max_replicas`: Skálázási beállítások
- `cpu_requests` / `memory_requests`: Erőforrás kérések

### Container Registry konfiguráció
- `container_registry_host`: Container Registry host neve (pl. your-registry.azurecr.io)
- `container_registry_username`: Container Registry felhasználónév

### Key Vault integráció
- `key_vault_name`: Meglévő Key Vault neve (üresen hagyva Key Vault nélkül)
- `key_vault_resource_group_name`: Key Vault Resource Group neve (üresen hagyva a fő Resource Group használatához)

### Környezeti változók és titkos kulcsok
- `container_env_variables`: Normál környezeti változók
- `container_env_secrets`: Titkos környezeti változók (Key Vault referenciákkal)
- `container_secrets`: Container titkos kulcsok (Key Vault referenciákkal)

### Címkék
- `tags`: Azure erőforrások címkézése

## Létrehozott erőforrások

- **Resource Group**: Meglévő Resource Group használata (`rg-ai-feature`)
- **Log Analytics Workspace**: Logok gyűjtése és monitorozás
- **Container App Environment**: Meglévő vagy új Container App környezet
- **Container App**: A tényleges alkalmazás
- **Key Vault integráció**: Opcionális titkos kulcsok kezelése (ha konfigurálva)
- **Container Registry**: Privát registry integráció (ha konfigurálva)

## Funkciók

- ✅ **Automatikus skálázás**: 0-10 replika között (konfigurálható)
- ✅ **Key Vault integráció**: Biztonságos titkos kulcsok kezelése
- ✅ **Container Registry**: Privát registry támogatás
- ✅ **Környezeti változók**: Normál és titkos változók kezelése
- ✅ **Log Analytics**: Teljes monitorozás és naplózás
- ✅ **Resource tagging**: Azure erőforrások címkézése

## Törlés

```bash
terraform destroy
```

## Hasznos parancsok

```bash
# Állapot megtekintése
terraform show

# Kimeneti értékek listázása
terraform output

# Konkrét kimenet lekérése
terraform output container_app_url
```

## Hibaelhárítás

Ha problémák merülnek fel:

1. Ellenőrizd az Azure CLI bejelentkezést: `az account show`
2. Ellenőrizd a jogosultságokat: `az role assignment list --assignee $(az account show --query user.name -o tsv)`
3. Nézd meg a Terraform logokat: `TF_LOG=DEBUG terraform apply`
