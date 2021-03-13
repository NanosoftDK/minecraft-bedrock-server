az storage account create     --resource-group nni-app-minecraft-p     --name nnisaminecraftp     --kind StorageV2     --sku Standard_ZRS     --enable-large-file-share     --output none

$storageAccountKey=(az storage account keys list --resource-group nni-app-minecraft-p --account-name nnisaminecraftp --query "[0].value" | tr -d '"')

az storage share create --account-name nnisaminecraftp  --account-key $storageAccountKey --name minecraftworld1  --quota 1024 --output none

az container create --resource-group nni-app-minecraft-p --name nni-cni-minecraft-p --image itzg/minecraft-bedrock-server:latest --dns-name-label nanoworld  --ports 19132  --protocol UDP     --azure-file-volume-account-name nnisaminecraftp     --azure-file-volume-account-key $storageAccountKey     --azure-file-volume-share-name minecraftworld1     --azure-file-volume-mount-path /data     --environment-variables 'EULA'='TRUE' 'GAMEMODE'='survival' 'DIFFICULTY'='normal'