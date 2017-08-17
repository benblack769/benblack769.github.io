page:
[{{page.title}}]({{page.url}})
links:
{% for node in site.pages %}
{% if node.url contains page.url %}
[{{node.title}}]({{node.url}})
{% endif %}
{% endfor %}
