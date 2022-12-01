procedure enviarEmailNotasBraspress is
  sTexto varchar2(1500);
  sEmail varchar2(250);
  sNomeArquivo varchar2(20);
  sPathArquivo varchar2(150);
  
  Begin
    for cNumSeq in (select b.num_seq_nfe
                    from movfat a, nfepack.interf_nfe b
                  where a.operacao = 'S' 
                    and a.transportadora = '48740351011361'                     
                    and a.dt_saida = trunc(sysdate)
                    and b.a_id = a.chave_nfe) 
    loop
      begin
         if (sTexto is not null) then          
           sTexto := sTexto || ';' || cNumSeq.Num_Seq_Nfe;
         else
           sTexto := cNumSeq.Num_Seq_Nfe;
         end if;   
      end;
    end loop;
                
    for cEmail in (select c.email 
                      from email_job c 
                     where c.numreg = 5)
    loop
      begin
        if (sEmail is not null) then
          sEmail := sEmail || ';' || cEmail.Email;
        else
          sEmail := cEmail.Email;
        end if;                
      end;
    end loop;
    
    sNomeArquivo := 'danfe_' || to_char(sysdate, 'ddmmyyyy') || '.PDF';
    
    select d.dsvalor into sPathArquivo from tparametros d where d.dscampo = 'PATH_EMAIL_BRASPRESS';
    
    if (sEmail is not null) and (sTexto is not null) and (sPathArquivo is not null) then
       
       INSERT INTO nfepack.comando_nfepack (NUM_SEQ_COMAND, IND_ACAO, STATUS_COMAND, IND_RESPON_EXEC, DSC_PARAM, dat_hor_agen_comand)
       VALUES (nfepack.SQ_COMAND_INTEGR_01.nextval, 8, 0, 1, 
       sTexto || '|' || sPathArquivo || '|' || sEmail ||  '|15M|1|0|' || sNomeArquivo || '|001', to_timestamp((sysdate) || ' 14:05', 'dd/mm/yyyy HH24:MI'));    
       commit;       
       
    end if; 
  End;    
