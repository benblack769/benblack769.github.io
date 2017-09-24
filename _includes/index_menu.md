links:
{% for node in site.pages %}
{% if node.url contains page.url and node.url != page.url and node.under_construction == false %}
[{{node.title}}]({{node.url}})
{% endif %}
{% endfor %}
