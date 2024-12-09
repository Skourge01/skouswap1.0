## Criar o swapfile 
sudo fallocate -l 5G /swapfile 
## alterar as permissoes do swapfile em 600 
sudo chmod 600 /swapfile 
# criar o swap 
sudo mkswap /swapfile 
# deixar a swapfile on 
sudo swapon /swapfile 
# escrever na /etc/fstab para deixar permanente 
echo '/swapfile none swap defaults 0 0' | sudo tee -a /etc/fstab 

# swapiness 
#definir a swapiness como 20 para sysctl 
sudo sysctl vm.swapinness=20 
# por a swapiness de forma permanente 
echo "vm.swapinness=20" | sudo tee -a /etc/sysctl.conf
# atualizar 
sudo sysctl -p 

# zram
# baixar o zram-generator 
sudo pacman -S zram-generator 
# escrever de forma permanente a zram 
echo "[zram0]" | sudo tee /etc/systemd/zram-generator.conf
echo "zram-size = 4096" | sudo tee -a /etc/systemd/zram-generator.conf
echo "compression-algorithm = zstd" | sudo tee -a /etc/systemd/zram-generator.conf
# atualizar 
sudo systemctl restart systemd-zram-setup@zram0.service
