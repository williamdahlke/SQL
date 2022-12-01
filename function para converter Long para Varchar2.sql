  Function ConverterObsOCLongVarchar2 (pOC varchar2) return varchar2 is
     sTextoConv varchar2(1500);    
  Begin
    for c1 in (select cadoc.observacao from cadoc where cadoc.ordem = pOC) loop
      begin
         sTextoConv := substr(c1.observacao,1,1500);      
      end;
    end loop;
    return sTextoConv;    
  End;
