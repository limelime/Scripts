export GV_VAR=Hello

GF_FOO ()
{
  echo "Say Hi."
}

export -f GF_FOO

./ExportTutorialSub.sh