# Filtering Apps

Metadata:
- name: $id
- description: meta.description && meta.longDescription
- author: ?
- license: meta.license
- homepage: meta.homepage
- isGui: `-e $out/share/applications/*`
- icon: `$out/share/applications/$id.desktop, $out/share/icons/*/$id.*, $out/share/applications/*.desktop, $out/share/icons/*/*.*`
- screenshots:
  - install and run with xvfb, make a screenshot after 5s
  - ignore if fails
