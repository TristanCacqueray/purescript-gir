module Gio.DBusConnection where

import Data.Nullable (Nullable, toNullable)
import Prelude (Unit)
import Data.Maybe (Maybe)
import Effect (Effect)
import GLib.Variant (Variant)
import GLib.VariantType (VariantType)
import Gio.DBusSignalFlags (DBusSignalFlags)
import Gio.DBusCallFlags (DBusCallFlags)

foreign import data DBusConnection :: Type

foreign import session :: DBusConnection

foreign import system :: DBusConnection

type DBusSignalCallback
  = DBusConnection ->
    -- | sender name
    String ->
    -- | object path
    String ->
    -- | interface name
    String ->
    -- | signal name
    String ->
    -- | value
    Variant ->
    Effect Unit

-- TODO
type Cancellable
  = Unit

foreign import call_sync_impl :: DBusConnection -> Nullable String -> String -> String -> String -> Nullable Variant -> Nullable VariantType -> DBusCallFlags -> Int -> Nullable Cancellable -> Effect Variant

call_sync ::
  DBusConnection ->
  Maybe String ->
  String ->
  String ->
  String ->
  Maybe Variant ->
  Maybe VariantType ->
  DBusCallFlags ->
  Int ->
  Maybe Cancellable ->
  Effect Variant
call_sync conn bus_name object_path interface_name method_name parameters reply_type flags timeout_msec cancellable =
  call_sync_impl
    conn
    (toNullable bus_name)
    object_path
    interface_name
    method_name
    (toNullable parameters)
    (toNullable reply_type)
    flags
    timeout_msec
    (toNullable cancellable)

foreign import data DBusSubscriptionId :: Type

foreign import signal_unsubscribe :: DBusSubscriptionId -> Effect Unit

foreign import signal_subscribe_impl ::
  DBusConnection ->
  Nullable String ->
  Nullable String ->
  Nullable String ->
  Nullable String ->
  Nullable String ->
  DBusSignalFlags ->
  DBusSignalCallback ->
  Effect DBusSubscriptionId

signal_subscribe ::
  DBusConnection ->
  Maybe String ->
  Maybe String ->
  Maybe String ->
  Maybe String ->
  Maybe String ->
  DBusSignalFlags ->
  DBusSignalCallback ->
  Effect DBusSubscriptionId
signal_subscribe conn sender interface member object arg0 flags cb =
  signal_subscribe_impl
    conn
    (toNullable sender)
    (toNullable interface)
    (toNullable member)
    (toNullable object)
    (toNullable arg0)
    flags
    cb
