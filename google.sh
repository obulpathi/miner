# TODO:
# 
# Create a presistent bootsisk, install software and set everything,
# machine type: n1-highcpu-8
# maximum number of CPUs = 24
# just launch and be done ... 
# check periodicall and be done ... 
# install git, vim and make
# have to use screen so that conneciton will not terminate
gcutil auth --project=meteor-shower
gcutil getproject --project=meteor-shower --cache_flag_values
# add any firewall if necessary
# gcutil addinstance <instance-name> --persistent_boot_disk
gcutil addinstance machine_name --persistent_boot_disk
gcutil getinstance machine_name


# screen commands
screen -dmS "top" top
screen -r top
screen -d top
