pkgs:

{
  meros.bundle.devTools.pkgs = with pkgs; [ gcc vim cmake gparted ];
  meros.bundle.editingTools.pkgs = with pkgs; [ gimp inkscape krita ]; # openshot-qt
}
