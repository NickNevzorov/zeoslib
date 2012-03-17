{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{               Component Property Editors                }
{                                                         }
{        Originally written by Sergey Seroukhov           }
{                                                         }
{*********************************************************}

{@********************************************************}
{    Copyright (c) 1999-2006 Zeos Development Group       }
{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ The source code of the ZEOS Libraries and packages are  }
{ distributed under the Library GNU General Public        }
{ License (see the file COPYING / COPYING.ZEOS)           }
{ with the following  modification:                       }
{ As a special exception, the copyright holders of this   }
{ library give you permission to link this library with   }
{ independent modules to produce an executable,           }
{ regardless of the license terms of these independent    }
{ modules, and to copy and distribute the resulting       }
{ executable under terms of your choice, provided that    }
{ you also meet, for each linked independent module,      }
{ the terms and conditions of the license of that module. }
{ An independent module is a module which is not derived  }
{ from or based on this library. If you modify this       }
{ library, you may extend this exception to your version  }
{ of the library, but you are not obligated to do so.     }
{ If you do not wish to do so, delete this exception      }
{ statement from your version.                            }
{                                                         }
{                                                         }
{ The project web site is located on:                     }
{   http://zeos.firmos.at  (FORUM)                        }
{   http://zeosbugs.firmos.at (BUGTRACKER)                }
{   svn://zeos.firmos.at/zeos/trunk (SVN Repository)      }
{                                                         }
{   http://www.sourceforge.net/projects/zeoslib.          }
{   http://www.zeoslib.sourceforge.net                    }
{                                                         }
{                                                         }
{                                                         }
{                                 Zeos Development Group. }
{********************************************************@}

unit ZPropertyEditor;

interface

{$I ZComponent.inc}

{$IFDEF WITH_PROPERTY_EDITOR}

uses
  Types, Classes, ZClasses, ZCompatibility, ZDbcIntfs, ZGroupedConnection , ZConnectionGroup, ZAbstractConnection,
{$IFDEF BDS4_UP}
  WideStrings,
{$ENDIF}
{$IFNDEF FPC}
  DesignIntf, DesignEditors;
{$ELSE}
    PropEdits;
{$ENDIF}

type

  {** Implements the basic methods of the property editor. }
  TZStringProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual; abstract;
    procedure GetValues(Proc: TGetStrProc); override;
    function  GetZComponent:TPersistent; virtual;
  end;

  {** Shows all Fields received from FieldDefs. }
  TZDataFieldPropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Fields received from IndexDefs - not used yet. }
  TZIndexFieldPropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Fields received from the MasterSource's DataSet.FieldDefs. }
  TZMasterFieldPropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Tables received from Connection.IZDatabaseMetadata. }
  TZTableNamePropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Procedures received from Connection.IZDatabaseMetadata. }
  TZProcedureNamePropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Sequences received from Connection.IZDatabaseMetadata. }
  TZSequenceNamePropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Implements a property editor for ZConnection.Protocol property. }
  TZProtocolPropertyEditor = class(TZStringProperty)
  public
    function  GetValue: string; override;
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;

  {** Implements a property editor for ZConnection.ClientCodePage property. }
  TZClientCodePagePropertyEditor = class(TZStringProperty)
  public
    function  GetValue: string; override;
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;

  {** Implements a property editor for ZConnection.Database property. }
  TZDatabasePropertyEditor = class(TZStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
    procedure Edit; override;
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;

  // Modified by Una.Bicicleta 2010/10/31
  {** Implements a property editor for ZConnectionGroup.Database property. }
  TZConnectionGroupPropertyEditor = class(TZStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
    procedure Edit; override;
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;

  {** Implements a property editor for ZGroupedConnection.Catalog property. }
  TZGroupedConnectionCatalogPropertyEditor = class(TZStringProperty)
  public
    function  GetValue: string; override;
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;

  /////////////////////////////////////////////////////////


  {** Implements a property editor for ZConnection.Catalog property. }
  TZCatalogPropertyEditor = class(TZStringProperty)
  public
    function  GetValue: string; override;
    procedure GetValueList(List: TStrings); override;
    procedure SetValue(const Value: string); override;
  end;

{$IFDEF USE_METADATA}
  {** Shows all Catalogs received from Connection.IZDatabaseMetadata. }
  TZCatalogProperty = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Columns received from Connection.IZDatabaseMetadata. }
  TZColumnNamePropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Schemes received from Connection.IZDatabaseMetadata. }
  TZSchemaPropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {** Shows all Types received from Connection.IZDatabaseMetadata. }
  TZTypeNamePropertyEditor = class(TZStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;
{$ENDIF}

const
  CRLF = LineEnding;

{$ENDIF}

implementation

{$IFDEF WITH_PROPERTY_EDITOR}

uses SysUtils, Forms, Dialogs, Controls, DB, TypInfo,
  ZConnection, ZSelectSchema
{$IFDEF USE_METADATA}
  , ZSqlMetadata
{$ENDIF}
{$IFNDEF UNIX}
  {$IFNDEF FPC}
  {$IFDEF ENABLE_ADO}
, ZDbcAdoUtils
  {$ENDIF}
  {$ENDIF}
{$ENDIF}
{$IFDEF SHOW_WARNING} 
,ZMessages 
{$ENDIF SHOW_WARNING} 
;

{$IFDEF FPC}
procedure GetItemNames(FieldDefs: TFieldDefs; List: TStrings); overload;
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Pred(FieldDefs.Count) do
    List.Append(FieldDefs[i].Name);
end;

procedure GetItemNames(IndexDefs: TIndexDefs; List: TStrings); overload;
var
  i: Integer;
begin
  List.Clear;
  for i := 0 to Pred(IndexDefs.Count) do
    List.Append(IndexDefs[i].Name);
end;
{$ENDIF}

{ Returns the IndexDefs from Dataset }
function GetIndexDefs(Component: TPersistent): TIndexDefs;
var
  DataSet: TDataSet;
begin
  DataSet := Component as TDataSet;
  Result := GetObjectProp(DataSet, 'IndexDefs') as TIndexDefs;
  if Assigned(Result) then
  begin
    Result.Updated := False;
    Result.Update;
  end;
end;

function IsEmpty(const s: string): Boolean;
begin
  Result := Trim(s) = '';
end;

{ TZStringProperty }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

{**
  Processes a list of list items.
  @param Proc a procedure to process the list items.
}
procedure TZStringProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for i := 0 to Pred(Values.Count) do
      Proc(Values[i]);
  finally
    Values.Free;
  end;
end;

{**
  Gets the component that has the property.
}
function TZStringProperty.GetZComponent:TPersistent;
begin
  Result:=GetComponent(0);
end;

{ TZDataFieldPropertyEditor }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZDataFieldPropertyEditor.GetValueList(List: TStrings);
begin
  try
    with (GetZComponent as TDataSet) do
    begin
      // Update the FieldDefs and return the Fieldnames
      FieldDefs.Updated := False;
      FieldDefs.Update;
      {$IFNDEF FPC}
      FieldDefs.GetItemNames(List);
      {$ELSE}
      GetItemNames(FieldDefs, List);
      {$ENDIF}
    end;
  except
  end;
end;

{ TZIndexFieldPropertyEditor }

procedure TZIndexFieldPropertyEditor.GetValueList(List: TStrings);
begin
  {$IFNDEF FPC}
  GetIndexDefs(GetZComponent).GetItemNames(List);
  {$ELSE}
  GetItemNames(GetIndexDefs(GetZComponent), List);
  {$ENDIF}
end;

{ TZMasterFieldPropertyEditor }

procedure TZMasterFieldPropertyEditor.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
begin
  DataSource := GetObjectProp(GetZComponent, 'MasterSource') as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    {$IFDEF BDS4_UP}
    DataSource.DataSet.GetFieldNames(TWideStrings(List));
    {$ELSE}
    DataSource.DataSet.GetFieldNames(List);
    {$ENDIF}
end;

{ TZTableNamePropertyEditor }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZTableNamePropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
  Schema, Tablename:String;
  IdentifierConvertor: IZIdentifierConvertor;
  Catalog: string;
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  begin
    Metadata := Connection.DbcConnection.GetMetadata;
    IdentifierConvertor := Metadata.GetIdentifierConvertor;
    Catalog := Connection.Catalog;
    Schema := '';
{$IFDEF USE_METADATA}
    if GetZComponent is TZSqlMetadata then
    begin
      Catalog := GetStrProp(GetZComponent, 'Catalog');
      Schema := GetStrProp(GetZComponent, 'Schema');
{$IFDEF SHOW_WARNING}
      if not (IsEmpty(Catalog) and IsEmpty(Schema)) or
       (MessageDlg(SPropertyQuery + CRLF + SPropertyTables + CRLF +
        SPropertyExecute, mtWarning, [mbYes,mbNo], 0) = mrYes) then
        begin
        // continue
        end
      else
        exit;
{$ENDIF}
    end;
{$ENDIF}
    begin
      try
        // Look for the Tables of the defined Catalog and Schema
        ResultSet := Metadata.GetTables(Catalog, Schema, '', nil);
        while ResultSet.Next do
          begin
            TableName := ResultSet.ZString(ResultSet.GetStringByName('TABLE_NAME'));
            TableName := IdentifierConvertor.Quote(TableName);
            Schema := ResultSet.ZString(ResultSet.GetStringByName('TABLE_SCHEM'));
            if Schema <> '' then
              TableName := IdentifierConvertor.Quote(Schema) + '.' + TableName;
            if Connection.Catalog <> '' then
              TableName := IdentifierConvertor.Quote(Connection.Catalog) + '.' + TableName;
            List.Add(TableName);
          end;
      finally
        ResultSet.Close;
      end;
    end;
  end;
end;

{ TZProcedureNamePropertyEditor }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZProcedureNamePropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
{$IFDEF USE_METADATA}
  Catalog, Schema: string;
{$ENDIF}
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  begin
{$IFDEF USE_METADATA}
    if GetZComponent is TZSqlMetadata then
    begin
      Catalog := GetStrProp(GetZComponent, 'Catalog');
      Schema := GetStrProp(GetZComponent, 'Schema');
{$IFDEF SHOW_WARNING}
      if not (IsEmpty(Catalog) and IsEmpty(Schema)) or
       (MessageDlg(SPropertyQuery + CRLF + SPropertyProcedures + CRLF +
        SPropertyExecute, mtWarning, [mbYes,mbNo], 0) = mrYes) then
{$ENDIF}
      try
        Metadata := Connection.DbcConnection.GetMetadata;
        // Look for the Procedures of the defined Catalog and Schema
        ResultSet := Metadata.GetProcedures(Catalog, Schema, '');
        while ResultSet.Next do
          List.Add(ResultSet.ZString(ResultSet.GetStringByName('PROCEDURE_NAME')));
      finally
        ResultSet.Close;
      end;
    end
    else
{$ENDIF}
    begin
      try
        Metadata := Connection.DbcConnection.GetMetadata;
        // Look for the Procedures
        ResultSet := Metadata.GetProcedures(Connection.Catalog, '', '');
        while ResultSet.Next do
          List.Add(ResultSet.ZString(ResultSet.GetStringByName('PROCEDURE_NAME')));
      finally
        ResultSet.Close;
      end;
    end;
  end;
end;

{ TZSequenceNamePropertyEditor }

{**
  Gets a selected string value.
  @return a selected string value.
}
procedure TZSequenceNamePropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
{$IFDEF USE_METADATA}
  Catalog, Schema: string;
{$ENDIF}
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  begin
{$IFDEF USE_METADATA}
    if GetZComponent is TZSqlMetadata then
    begin
      Catalog := GetStrProp(GetZComponent, 'Catalog');
      Schema := GetStrProp(GetZComponent, 'Schema');
{$IFDEF SHOW_WARNING}
      if not (IsEmpty(Catalog) and IsEmpty(Schema)) or
       (MessageDlg(SPropertyQuery + CRLF + SPropertySequences + CRLF +
        SPropertyExecute, mtWarning, [mbYes,mbNo], 0) = mrYes) then
{$ENDIF}
      try
        Metadata := Connection.DbcConnection.GetMetadata;
        // Look for the Procedures of the defined Catalog and Schema
        ResultSet := Metadata.GetSequences(Catalog, Schema, '');
        while ResultSet.Next do
          List.Add(ResultSet.ZString(ResultSet.GetStringByName('SEQUENCE_NAME')));
      finally
        ResultSet.Close;
      end;
    end
    else
{$ENDIF}
    begin
      try
        Metadata := Connection.DbcConnection.GetMetadata;
        // Look for the Procedures
        ResultSet := Metadata.GetSequences(Connection.Catalog, '', '');
        while ResultSet.Next do
          if ResultSet.GetStringByName('SEQUENCE_SCHEM') <> '' then
            List.Add(ResultSet.ZString(ResultSet.GetStringByName('SEQUENCE_SCHEM'))+
              '.'+ResultSet.ZString(ResultSet.GetStringByName('SEQUENCE_NAME')))
          else
            List.Add(ResultSet.ZString(ResultSet.GetStringByName('SEQUENCE_NAME')));
      finally
        ResultSet.Close;
      end;
    end;
  end;
end;

{ TZProtocolPropertyEditor }

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZProtocolPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZProtocolPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetZComponent is TZAbstractConnection then
    (GetZComponent as TZAbstractConnection).Connected := False;
end;

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZProtocolPropertyEditor.GetValueList(List: TStrings);
var
  I, J: Integer;
  Drivers: IZCollection;
  Protocols: TStringDynArray;
begin
  Drivers := DriverManager.GetDrivers;
  Protocols := nil;
  for I := 0 to Drivers.Count - 1 do
  begin
    Protocols := (Drivers[I] as IZDriver).GetSupportedProtocols;
    for J := Low(Protocols) to High(Protocols) do
      List.Append(Protocols[J]);
  end;
end;

{TZClientCodePagePropertyEditor -> EgonHugeist 19.01.2012}

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
function  TZClientCodePagePropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZClientCodePagePropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  I: Integer;
  SDyn: TStringDynArray;
  S: String;
begin

  if GetZComponent is TZAbstractConnection then
    Connection := (GetZComponent as TZAbstractConnection)
  else
    Connection := nil;

  if Assigned(Connection) then
  begin
    if Connection.Protocol = '' then
      List.Append('No Protocol selected!')
    else
    begin
      s := DriverManager.ConstructURL(Connection.Protocol, '', '', '', '', 0);
      SDyn := DriverManager.GetDriver(s).GetSupportedClientCodePages(s, True);
      for i := 0 to high(SDyn) do
        List.Append(SDyn[i]);

      TStringList(List).Sort;
    end;
  end;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZClientCodePagePropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetZComponent is TZAbstractConnection then
    (GetZComponent as TZAbstractConnection).Connected := False;
end;


{ TZDatabasePropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZDatabasePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  if GetZComponent is TZAbstractConnection then
  begin
    if ((GetZComponent as TZAbstractConnection).Protocol = 'mssql') or
    ((GetZComponent as TZAbstractConnection).Protocol = 'sybase') then
      Result := inherited GetAttributes
    else
      Result := [paDialog];
  end;
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZDatabasePropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZDatabasePropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
  if GetZComponent is TZAbstractConnection then
    (GetZComponent as TZAbstractConnection).Connected := False;
end;

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZDatabasePropertyEditor.GetValueList(List: TStrings);
var
  DbcConnection: IZConnection;
  Url: string;
begin
  if GetZComponent is TZAbstractConnection then
  try
    URL := (GetZComponent as TZAbstractConnection).GetURL;
      (GetZComponent as TZAbstractConnection).ShowSqlHourGlass;
    try
      DbcConnection := DriverManager.GetConnectionWithParams(Url,
        (GetZComponent as TZAbstractConnection).Properties);

      with DbcConnection.GetMetadata.GetCatalogs do
      try
        while Next do
          List.Append(ZString(GetStringByName('TABLE_CAT')));
      finally
        Close;
      end;

    finally
      (GetZComponent as TZAbstractConnection).HideSqlHourGlass;
    end;
  except
//    raise;
  end;
end;

{**
  Brings up the proper database property editor dialog.
}
procedure TZDatabasePropertyEditor.Edit;
var
  OD: TOpenDialog;
begin
  if GetZComponent is TZAbstractConnection then
  begin
    if ((GetZComponent as TZAbstractConnection).Protocol = 'mssql') or
    ((GetZComponent as TZAbstractConnection).Protocol = 'sybase') then
      inherited
{$IFNDEF UNIX}
{$IFNDEF FPC}
{$IFDEF ENABLE_ADO}
    else
    if ((GetZComponent as TZAbstractConnection).Protocol = 'ado') then
      (GetZComponent as TZAbstractConnection).Database := PromptDataSource(Application.Handle,
        (GetZComponent as TZAbstractConnection).Database)
{$ENDIF}
{$ENDIF}
{$ENDIF}
    else
    begin
      OD := TOpenDialog.Create(nil);
      try
        OD.InitialDir := ExtractFilePath((GetZComponent as TZAbstractConnection).Database);
        if OD.Execute then
          (GetZComponent as TZAbstractConnection).Database := OD.FileName;
      finally
        OD.Free;
      end;
    end;
  end
  else
    inherited;
end;

{ TZCatalogPropertyEditor }

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZCatalogPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZCatalogPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZCatalogPropertyEditor.GetValueList(List: TStrings);
var
  DbcConnection: IZConnection;
  Url: string;
begin
  if GetZComponent is TZAbstractConnection then
  try
    URL := (GetZComponent as TZAbstractConnection).GetURL;
    (GetZComponent as TZAbstractConnection).ShowSqlHourGlass;
    try
      DbcConnection := DriverManager.GetConnectionWithParams(Url,
        (GetZComponent as TZAbstractConnection).Properties);

      with DbcConnection.GetMetadata.GetCatalogs do
      try
        while Next do
          List.Append(ZString(GetStringByName('TABLE_CAT')));
      finally
        Close;
      end;

    finally
      (GetZComponent as TZAbstractConnection).HideSqlHourGlass;
    end;
  except
//    raise;
  end;
end;

{$IFDEF USE_METADATA}

{ TZCatalogProperty }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZCatalogProperty.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  try
    Metadata := Connection.DbcConnection.GetMetadata;
    ResultSet := Metadata.GetCatalogs;
    while ResultSet.Next do
      List.Add(ResultSet.ZString(ResultSet.GetStringByName('TABLE_CAT')));
  finally
    ResultSet.Close;
  end;
end;

{ TZColumnNamePropertyEditor }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZColumnNamePropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
  Catalog, Schema, TableName: string;
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  begin
    Catalog := GetStrProp(GetZComponent, 'Catalog');
    Schema := GetStrProp(GetZComponent, 'Schema');
    TableName := GetStrProp(GetZComponent, 'TableName');
{$IFDEF SHOW_WARNING}
    if not IsEmpty(TableName) or not (IsEmpty(Schema) and IsEmpty(Schema)) or
     (MessageDlg(SPropertyQuery + CRLF + SPropertyTables + CRLF +
      SPropertyExecute, mtWarning, [mbYes,mbNo], 0) = mrYes) then
{$ENDIF}
    try
      Metadata := Connection.DbcConnection.GetMetadata;
      // Look for the Columns of the defined Catalog, Schema and TableName
      ResultSet := Metadata.GetColumns(Catalog, Schema, TableName, '');
      while ResultSet.Next do
        if List.IndexOf(ResultSet.ZString(ResultSet.GetStringByName('COLUMN_NAME'))) = -1 then
          List.Add(ResultSet.ZString(ResultSet.GetStringByName('COLUMN_NAME')));
    finally
      ResultSet.Close;
    end;
  end;
end;

{ TZSchemaPropertyEditor }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZSchemaPropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  try
    Metadata := Connection.DbcConnection.GetMetadata;
    ResultSet := Metadata.GetSchemas;
    while ResultSet.Next do
      List.Add(ResultSet.ZString(ResultSet.GetStringByName('TABLE_SCHEM')));
  finally
    ResultSet.Close;
  end;
end;

{ TZTypeNamePropertyEditor }

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZTypeNamePropertyEditor.GetValueList(List: TStrings);
var
  Connection: TZAbstractConnection;
  Metadata: IZDatabaseMetadata;
  ResultSet: IZResultSet;
begin
  Connection := GetObjectProp(GetZComponent, 'Connection') as TZAbstractConnection;
  if Assigned(Connection) and Connection.Connected then
  try
    Metadata := Connection.DbcConnection.GetMetadata;
    ResultSet := Metadata.GetTypeInfo;
    while ResultSet.Next do
      List.Add(ResultSet.ZString(ResultSet.GetStringByName('TYPE_NAME')));
  finally
    ResultSet.Close;
  end;
end;


//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

{ TZConnectionGroupCatalogPropertyEditor }


function TZGroupedConnectionCatalogPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TZGroupedConnectionCatalogPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

procedure TZGroupedConnectionCatalogPropertyEditor.GetValueList(List: TStrings);
var
  DbcConnection: IZConnection;
  Url: string;
begin
  if GetZComponent is TZAbstractConnection then
  try
    URL := (GetZComponent as TZAbstractConnection).GetURL;
    (GetZComponent as TZAbstractConnection).ShowSqlHourGlass;
    try
      DbcConnection := DriverManager.GetConnectionWithParams(Url,
        (GetZComponent as TZAbstractConnection).Properties);

      with DbcConnection.GetMetadata.GetCatalogs do
      try
        while Next do
          List.Append(ZString(GetStringByName('TABLE_CAT')));
      finally
        Close;
      end;

    finally
      (GetZComponent as TZAbstractConnection).HideSqlHourGlass;
    end;
  except
//    raise;
  end;
end;




{ TZConnectionGroupPropertyEditor }

{**
  Gets a type of property attributes.
  @return a type of property attributes.
}
function TZConnectionGroupPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  if GetZComponent is TZConnectionGroup then
  begin
    if ((GetZComponent as TZConnectionGroup).Protocol = 'mssql') or
    ((GetZComponent as TZConnectionGroup).Protocol = 'sybase') then
      Result := inherited GetAttributes
    else
      Result := [paDialog];
  end;
end;

{**
  Gets a selected string value.
  @return a selected string value.
}
function TZConnectionGroupPropertyEditor.GetValue: string;
begin
  Result := GetStrValue;
end;

{**
  Sets a new selected string value.
  @param Value a new selected string value.
}
procedure TZConnectionGroupPropertyEditor.SetValue(const Value: string);
begin
  SetStrValue(Value);
//  if GetZComponent is TZConnectionGroup then
//    (GetZComponent as TZConnectionGroup).Connected := False;
end;

{**
  Processes a list of list items.
  @param List the list to process the list items.
}
procedure TZConnectionGroupPropertyEditor.GetValueList(List: TStrings);
var
  DbcConnection: IZConnection;
  Url: string;
begin
  if GetZComponent is TZConnectionGroup then
  try
    URL := (GetZComponent as TZAbstractConnection).GetURL;
    with DbcConnection.GetMetadata.GetCatalogs do
    try
      while Next do
        List.Append(ZString(GetStringByName('TABLE_CAT')));
    finally
      Close;
    end;
  except
//    raise;
  end;
end;

{**
  Brings up the proper database property editor dialog.
}
procedure TZConnectionGroupPropertyEditor.Edit;
var
  OD: TOpenDialog;
begin
  if GetZComponent is TZConnectionGroup then
  begin
    if ((GetZComponent as TZConnectionGroup).Protocol = 'mssql') or
    ((GetZComponent as TZConnectionGroup).Protocol = 'sybase') then
      inherited
{$IFNDEF UNIX}
{$IFNDEF FPC}
{$IFDEF ENABLE_ADO}
    else
    if ((GetZComponent as TZConnectionGroup).Protocol = 'ado') then
      (GetZComponent as TZConnectionGroup).Database := PromptDataSource(Application.Handle,
        (GetZComponent as TZConnectionGroup).Database)
{$ENDIF}
{$ENDIF}
{$ENDIF}
    else
    begin
      OD := TOpenDialog.Create(nil);
      try
        OD.InitialDir := ExtractFilePath((GetZComponent as TZConnectionGroup).Database);
        if OD.Execute then
          (GetZComponent as TZConnectionGroup).Database := OD.FileName;
      finally
        OD.Free;
      end;
    end;
  end
  else
    inherited;
end;



{$ENDIF}

{$ENDIF}

end.


