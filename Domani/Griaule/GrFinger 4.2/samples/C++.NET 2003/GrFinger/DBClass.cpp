/*
 -------------------------------------------------------------------------------
 GrFinger Sample
 (c) 2005 Griaule Tecnologia Ltda.
 http://www.griaule.com
 -------------------------------------------------------------------------------

 This sample is provided with "GrFinger Fingerprint Recognition Library" and
 can't run without it. It's provided just as an example of using GrFinger
 Fingerprint Recognition Library and should not be used as basis for any
 commercial product.

 Griaule Tecnologia makes no representations concerning either the merchantability
 of this software or the suitability of this sample for any particular purpose.

 THIS SAMPLE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL GRIAULE BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 You can download the free version of GrFinger directly from Griaule website.
                                                                   
 These notices must be retained in any copies of any part of this
 documentation and/or sample.

 -------------------------------------------------------------------------------
*/

// -----------------------------------------------------------------------------------
// Database routines
// -----------------------------------------------------------------------------------

#include "StdAfx.h"
#include "dbclass.h"
#include "GrFinger.h"

using namespace System::Data;

// the template class
TTemplate::TTemplate(void) {
	// Template data
	_tpt = new unsigned char [GR_MAX_SIZE_TEMPLATE];
	// Template size
	_size = 0;
}

TTemplate::~TTemplate(void) {
    delete [] _tpt;
}

// the database class
DBClass::DBClass(void) {
}

DBClass::~DBClass(void) {
}

// Open connection
bool DBClass::openDB() {
  _connection = new OleDbConnection();
  _connection->ConnectionString = CONNECTION_STRING;
  try{
    _connection->Open();
  }
  catch(OleDbException *e){
	(void)e;
    return false;
  }
  tptBlob = new TTemplate();
  return true;
}

// Close conection
bool DBClass::closeDB() {
  if(_connection->State != ConnectionState::Closed)
    _connection->Close();  
  delete tptBlob;
  return true;
}

// Clear database
bool DBClass::clearDB() {
  OleDbCommand *cmdClear = NULL;
  cmdClear = new OleDbCommand("DELETE FROM enroll", _connection);

  // run "clear" query
  if(_connection->get_State() == ConnectionState::Open)
    cmdClear->ExecuteNonQuery();

  return true;
}

// Add template to database. Returns added template ID.
bool DBClass::addTemplate(TTemplate *tpt, int *id) {
  OleDbCommand *cmdInsert = NULL;
  OleDbParameter *dbParamInsert = NULL; 
  OleDbCommand *cmdSelect =  NULL;

  try{
    // Create SQL command containing ? parameter for BLOB.
    cmdInsert = new OleDbCommand("INSERT INTO enroll(template) values(?) ", _connection);
    // Create parameter for ? contained in the SQL statement.
    System::Byte temp[] = __gc new System::Byte[tpt->_size + 1];
    System::Runtime::InteropServices::Marshal::Copy(tpt->_tpt, temp, 0, tpt->_size);

    dbParamInsert = new OleDbParameter("@template", OleDbType::VarBinary, tpt->_size, 
				       ParameterDirection::Input, false, 0, 0, 0, 
				       DataRowVersion::Current, temp);
    cmdInsert->Parameters->Add(dbParamInsert);

    //execute query
    if(_connection->get_State() == ConnectionState::Open)
      cmdInsert->ExecuteNonQuery();
  }
  catch(OleDbException *e){
    (void)e;
    return false;
  }

  try{
    // Create SQL command containing ? parameter for BLOB.
    cmdSelect = new OleDbCommand("SELECT top 1 ID FROM enroll ORDER BY ID DESC", _connection);
    
    *id = System::Convert::ToInt32(cmdSelect->ExecuteScalar());
  }
  catch(OleDbException *e){
	(void)e;
    return false;  
  }

  return true;
}

// Returns an OleDbDataReader with all enrolled templates from database.
OleDbDataReader* DBClass::getTemplates(){
  OleDbCommand *cmdGetTemplates;
  OleDbDataReader* rs;

  //setting up command 
  cmdGetTemplates =  new OleDbCommand("SELECT * FROM enroll", _connection);
  rs = cmdGetTemplates->ExecuteReader();

  return rs;
}

// Returns template with supplied ID.
TTemplate* DBClass::getTemplate(int id){
  OleDbCommand *cmd;
  OleDbDataReader *dr;
  tptBlob->_size = 0;

  try {
    cmd =  new OleDbCommand(System::String::Concat(S"SELECT * FROM enroll WHERE ID = ", System::Convert::ToString((unsigned int)id)), _connection);
    dr = cmd->ExecuteReader();
	// Get query response
    dr->Read();
    getTemplate(dr);
    dr->Close();
  }
  catch(...){
    dr->Close();  
  }
  return tptBlob; 
}

// Return template data from an OleDbDataReader
TTemplate* DBClass::getTemplate(OleDbDataReader *rs){
  int readedBytes;

  tptBlob->_size = 0;
  // alloc space
  System::Byte temp[] = __gc new System::Byte[GR_MAX_SIZE_TEMPLATE];
  // get bytes
  readedBytes = (int)rs->GetBytes(1, 0, temp, 0, temp->Length);
  // copy to structure
  System::Runtime::InteropServices::Marshal::Copy(temp, 0, tptBlob->_tpt, readedBytes);
  // set real size
  tptBlob->_size = readedBytes;
  return tptBlob;
}

// Return enrollment ID from an OleDbDataReader
int DBClass::getId(OleDbDataReader* rs){
  return rs->GetInt32(0);
}

