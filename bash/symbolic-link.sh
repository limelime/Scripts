
tmp_symbolic_file="$0_$(date +%N).tmp"
echo "test symbolic" > "${tmp_symbolic_file}"

echo "${tmp_symbolic_file}.ln" "${tmp_symbolic_file}"
ln -s "${tmp_symbolic_file}" "${tmp_symbolic_file}.ln"
ls -al ${tmp_symbolic_file}*

if [ -s "${tmp_symbolic_file}.ln" ] && [ ! -L "${tmp_symbolic_file}.ln" ]; then
  echo 'Is a file';
else
  echo 'Not a file';
fi