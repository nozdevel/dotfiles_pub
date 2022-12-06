#/bin/bash

argc=$#
apend="false"
tag_file="tags"
base_dir="."
exclude_dir=""
tmp_dir=""

readonly MEM_LIMIT=512M

function clean_up() {
    if [ -e ${tmp_dir} ]; then
        rm -rf ${tmp_dir}
    fi

    if [ -e ${file_chs} ]; then
        rm -rf ${file_chs}
    fi

    exit 0
}

trap clean_up 1 2 3 15

set -- `getopt ae: $*`

if [ $? -ne 0 ]; then
    echo "ftags.sh [-a] [-e exclude_dir] [base_dir]"
  exit 2
fi

while [ $# -gt 0 ]; do
    case $1 in
        -a)
            apend="true"
            shift
            ;;
        -e)
            exclude_dir=$2
            shift 2
            ;;
        *)
            base_dir=$2
            tmp_dir=${base_dir}/tmp_dir
            shift 2
            break
            ;;
    esac
done

mkdir -p ${tmp_dir}
file_chs=${base_dir}/file_chs.dat

if [ 'uname' == SunOS ] ; then
    if [ "$exclude_dir" != "" ]; then
        find ${base_dir} -name "*.[chs]" -or -name "*.cpp" > ${file_chs}
        sed -i "/${exclude_dir}\//d" ${file_chs}
    else
        find ${base_dir} -name "*.[chs]" -or -name "*.cpp" > ${file_chs}
    fi
else
    if [ "$exclude_dir" != "" ]; then
        find ${base_dir} -name "*.[chs]" -or -name "*.cpp" > ${file_chs}
        sed -i "/${exclude_dir}\//d" ${file_chs}
    else
        find ${base_dir} -name "*.[chs]" -or -name "*.cpp" > ${file_chs}
    fi
fi

if [ "$apend" == "false" ]; then
    /bin/rm -rf ${tag_file}
fi

while read full_pass
do
    file=`basename ${full_pass}`
    echo "${file}	${full_pass}	1;\"	d" >> ${tag_file}
done < ${file_chs}

LC_ALL=C sort --parallel=2 -S ${MEM_LIMIT} -T ${tmp_dir} --output=${tag_file} ${tag_file}

clean_up
