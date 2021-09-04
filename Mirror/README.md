Download Recursive Dependencies Of A Package

# Voir la liste des dep :

'''
apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances $PACKAGE | grep "^\w" | sort -u
'''

# Download all:

'''
apt-get download $(apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances $PACKAGE | grep "^\w" | sort -u)
'''

# Installer packages

'''
dpkg -i *
'''
