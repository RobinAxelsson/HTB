mkdir htb && cd htb && code .
target=<ip>
# create list

cat << EOF > list.txt
one
two
three
EOF

history | grep ssh