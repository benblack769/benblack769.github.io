
# assumes latex has already generated the pdfs
# should call latex commands to automatically generate these

# call
for i in $( cd diagram-tix; find . -name "*.pdf" ); do
    echo diagram-tix/$i
    pdf2svg diagram-tix/$i diagram-svg/$i.svg
done
#pdf2svg diagram-tix/diagram.pdf diagram-svg/feed-forward.svg
