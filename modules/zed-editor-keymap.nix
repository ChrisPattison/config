[
{
  context = "Editor";
  bindings = {
    "ctrl-x" = null;
    "ctrl-c" = null;
    "ctrl-v" = null;
    "ctrl-;" = null;
  };
}
{
  context = "Editor";
  bindings = {
    "ctrl-x ;" = ["editor::ToggleComments" { "advance_downwards" = false; }];
  };
}
{
  context = "Editor";
  bindings = {
    "ctrl-/" = "editor::Undo";
    "ctrl-k" = "editor::DeleteLine";
    "ctrl-w" = "editor::Cut";
    "alt-w" = "editor::Copy";
    "ctrl-y" = "editor::Paste";
    "ctrl-alt-/" = "editor::Redo";
    "ctrl-shift-p" = "editor::AddSelectionAbove";
    "ctrl-shift-n" = "editor::AddSelectionBelow";
  };
}
]
