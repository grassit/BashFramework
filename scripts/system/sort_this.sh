# Tars a given directory
# Usage: tar_dir dir
tar_dir() {
	dir="$1"
	tar -zcvf $dir.tar.gz $dir
}


# Creates an encrypted archive with no compression. Used for securing files. 
# Easier than gpg or bcrypt because:
# 1. With gpg you have two tar separately which is two steps
# 2. No need of specifying or remembering what algorithm and strength were used.
# Usage: 7z_encrypt dir password
7z_encrypt() {
	dir="$1"
	password="$2"
	7z a -t7z -mhe=on -p"$password" "$dir".7z "$dir" -m0=Copy
}