module Database.Postgres.SqlValue
  ( SqlValue()
  , IsSqlValue
  , toSql
  ) where

import Data.Int
import Data.Maybe

foreign import data SqlValue :: *

class IsSqlValue a where
  toSql :: a -> SqlValue

instance isSqlValueString :: IsSqlValue String where
  toSql = unsafeToSqlValue

instance isSqlValueNumber :: IsSqlValue Number where
  toSql = unsafeToSqlValue

instance isSqlValueInt :: IsSqlValue Int where
  toSql = unsafeToSqlValue <<< toNumber

instance isSqlValueMaybe :: (IsSqlValue a) => IsSqlValue (Maybe a) where
  toSql Nothing = nullSqlValue
  toSql (Just x) = toSql x

foreign import unsafeToSqlValue """
  function unsafeToSqlValue(x) {
    return x;
  }
  """ :: forall a. a -> SqlValue

foreign import nullSqlValue "var nullSqlValue = null;" :: SqlValue