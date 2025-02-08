{$IFDEF VER150}  // Delphi7
      {$Define DELPHI7_OR_ABOVE}
      {$Define DELPHI6_OR_ABOVE}
      {$Define DELPHI5_OR_ABOVE}
      {$Define DELPHI4_OR_ABOVE}
      {$Define DELPHI3_OR_ABOVE}
      {$Define DELPHI2_OR_ABOVE}
{$ELSE}
      {$IFDEF VER140} // Delphi 6
             {$Define DELPHI6_OR_ABOVE}
             {$Define DELPHI5_OR_ABOVE}
             {$Define DELPHI4_OR_ABOVE}
             {$Define DELPHI3_OR_ABOVE}
             {$Define DELPHI2_OR_ABOVE}
      {$ELSE}
             {$IFDEF VER130} // Delphi 5
                     {$Define DELPHI5_OR_ABOVE}
                     {$Define DELPHI4_OR_ABOVE}
                     {$Define DELPHI3_OR_ABOVE}
                     {$Define DELPHI2_OR_ABOVE}
             {$ELSE}
                     {$IFDEF VER125} // BCB 4
                            {$Define DELPHI4_OR_ABOVE}
                            {$Define DELPHI3_OR_ABOVE}
                            {$Define DELPHI2_OR_ABOVE}
                     {$ELSE}
                            {$IFDEF VER120} // Delphi 4
                                   {$Define DELPHI4_OR_ABOVE}
                                   {$Define DELPHI3_OR_ABOVE}
                                   {$Define DELPHI2_OR_ABOVE}
                            {$ELSE}
                                   {$IFDEF VER100} // Delphi 3
                                          {$Define DELPHI3_OR_ABOVE}
                                          {$Define DELPHI2_OR_ABOVE}
                                   {$ELSE}
                                          {$Define DELPHI2_OR_ABOVE}
                                   {$ENDIF}
                     {$ENDIF}
                     {$ENDIF}
             {$ENDIF}
      {$ENDIF}
{$ENDIF}

