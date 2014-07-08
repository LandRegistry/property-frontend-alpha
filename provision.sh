echo Update packages...
sudo apt-get install -qq update

echo Installing Git...
sudo apt-get install -qy git

echo Installing Python...
sudo apt-get install -y python-dev

echo Installing PIP...
sudo apt-get install -y python-pip

echo Installing Flask...
sudo pip install flask==0.10.1

echo Installing Jinja...
sudo pip install jinja2==2.7.2

echo Installing GUnicorn
sudo pip install gunicorn==18.0

echo 'cd /vagrant' >> /home/vagrant/.bash_profile
