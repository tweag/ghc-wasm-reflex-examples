module App (start) where

import GHC.Wasm.Prim
import Language.Javascript.JSaddle (JSM)
import Reflex.TodoMVC qualified

start :: JSString -> JSM ()
start e =
  case fromJSString e of
    "reflex-todomvc" -> Reflex.TodoMVC.main
    _ -> fail "unknown example"
