export GV_VAR=Hello

GF_FOO ()
{
  echo "Say Hi, ${GV_VAR}."
}

export -f GF_FOO

./ExportTutorialSub.sh
