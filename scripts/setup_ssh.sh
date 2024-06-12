# in case you want to run the script on windows, run it inside Git Bash
echo "Type the email you will associate with ssh and git: "
read email

while [[ $email -eq "" ]]; do
    echo "You cannot leave an empty email. Type again: "
    read email
done

echo "Give a name for the resulting ssh key file (otherwise will be named as ed25519): "
read keyname

if [[ $keyname -eq "" ]];
then
    $keyname="ed25519"
fi

private_ssh_keypath="$HOME/.ssh/$keyname"

ssh-keygen -t ed25519 -C $email -f $private_ssh_keypath
eval "$(ssh-agent -s)"
ssh-add $private_ssh_keypath

echo "SSH key added at '$private_ssh_keypath'."
echo "Now, add your public ssh key to the website destiny (github, gitlab, bitbucket)."
