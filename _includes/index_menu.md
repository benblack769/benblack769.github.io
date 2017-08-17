page:
[{{page.title}}]({{page.url}})
links:
{% for node in site.pages %}
[{{node.title}}]({{node.url}})
{% endfor %}
