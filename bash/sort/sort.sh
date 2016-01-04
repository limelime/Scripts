INPUT_FILE="people.txt"

CMD="cat ${INPUT_FILE}"
echo "${CMD}"
eval "${CMD}" | sed 's/^/#   /'; echo ""

echo "# Sort by the 3rd column"
SORT_CMD="sort -t ';' -k3,3n ${INPUT_FILE}"
echo "${SORT_CMD}"
eval "${SORT_CMD}" | sed 's/^/#   /'; echo ""

echo "# Sort by 2nd, 1st and then 3rd column"
SORT_CMD="sort -t ';' -k2,2 -k1,1 -k3,3n ${INPUT_FILE}"
echo "${SORT_CMD}" 
eval "${SORT_CMD}" | sed 's/^/#   /'; echo ""