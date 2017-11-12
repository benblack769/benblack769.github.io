Pages:

{% for post in site.pages %}
{% if post.url contains page.url and post.url != page.url and post.under_construction == false %}
{% include archive-single.html %}
{% endif %}
{% endfor %}
