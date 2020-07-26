# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server "54.248.115.87", user: "Riku", roles: %w{app db web}

# デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: "~/.ssh/Riku_key_rsa"
