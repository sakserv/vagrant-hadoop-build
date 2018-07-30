CONF_DIR=/vagrant/conf
SECURE_CONF_DIR=$CONF_DIR/secure
REALM="EXAMPLE.COM"
HOST="y7001.yns.example.com"

#
# Install krb
#
echo -e "\n##### Install MIT KDC and client"
yum install krb5-server krb5-libs krb5-workstation -y

#
# Configure krb
#
echo -e "\n##### Setup krb5.conf"
cp $SECURE_CONF_DIR/os/krb5.conf /etc/

#
# Configure and start KDC
#
echo -e "\n##### Configure and start the KDC"
kdb5_util create -s -P p@ssw0rd
systemctl start krb5kdc
systemctl start kadmin

#
# Add principals and generate keytabs
#
echo -e "\n##### Setup keytabs"
mkdir -p /etc/security/keytabs

# NN RPC
echo -e "\n##### Generating NN principal and keytab"
kadmin.local addprinc -randkey nn/${HOST}@${REALM}
kadmin.local xst -k /etc/security/keytabs/nn.service.keytab nn/${HOST}
chown hdfs:hadoop /etc/security/keytabs/nn.service.keytab

# DN RPC
echo -e "\n##### Generating DN principal and keytab"
kadmin.local addprinc -randkey dn/${HOST}@${REALM}
kadmin.local xst -k /etc/security/keytabs/dn.service.keytab dn/${HOST}
chown hdfs:hadoop /etc/security/keytabs/dn.service.keytab

# RM RPC
echo -e "\n##### Generating RM principal and keytab"
kadmin.local addprinc -randkey rm/${HOST}@${REALM}
kadmin.local xst -k /etc/security/keytabs/rm.service.keytab rm/${HOST}
chown yarn:hadoop /etc/security/keytabs/rm.service.keytab

# NM RPC
echo -e "\n##### Generating NM principal and keytab"
kadmin.local addprinc -randkey nm/${HOST}@${REALM}
kadmin.local xst -k /etc/security/keytabs/nm.service.keytab nm/${HOST}
chown yarn:hadoop /etc/security/keytabs/nm.service.keytab

# Zookeeper
echo -e "\n##### Generating ZK principal and keytab"
kadmin.local addprinc -randkey zookeeper/${HOST}@${REALM}
kadmin.local xst -k /etc/security/keytabs/zk.service.keytab zookeeper/${HOST}
chown zookeeper:hadoop /etc/security/keytabs/zk.service.keytab

# SPNEGO
echo -e "\n##### Generating SPNEGO principal and keytab"
kadmin.local addprinc -randkey HTTP/${HOST}@${REALM}
kadmin.local xst -k /etc/security/keytabs/spnego.service.keytab HTTP/${HOST}
chown hdfs:hadoop /etc/security/keytabs/spnego.service.keytab

# Hadoopuser headless
echo -e "\n##### Generating hadoopuser principal and keytab"
kadmin.local addprinc -randkey hadoopuser@${REALM}
kadmin.local xst -k /etc/security/keytabs/hadoopuser.headless.keytab hadoopuser
chown hadoopuser:hadoopuser /etc/security/keytabs/hadoopuser.headless.keytab

# Create complete marker
touch /tmp/bootstrap_krb.complete
