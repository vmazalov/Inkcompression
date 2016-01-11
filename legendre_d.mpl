readlib(readdata);with(orthopoly);
kernelopts(printbytes = false);

Digits := 10; maxerlim := 40;
for digs from 3 to 10 do for d from 4 to 20 do points := readdata(`/scl/people/vadim/Dropbox/invariants_mine/approx/points0`, integer, 2); a := 1; inter := 2; b := a+inter; curerror := 20; totalcoefs := 0; totalpoints := 0; while nops(points) > inter do finalx := 0; finaly := 0; for m from 0 to d do integx := 0; integy := 0; for k from a to b-1 do fxa := points[k, 1]; fxb := points[k+1, 1]; fya := points[k, 2]; fyb := points[k+1, 2]; integx := integx+round(evalf(int((fxa+(fxb-fxa)*(x-k)/(k+1-k))*subs(y = (2*x-b-a)/(b-a), P(m, y)), x = k .. k+1))); integy := integy+round(evalf(int((fya+(fyb-fya)*(x-k)/(k+1-k))*subs(y = (2*x-b-a)/(b-a), P(m, y)), x = k .. k+1))) end do; coefsx[m] := evalf[digs](integx*(2*m+1)/(b-a)); coefsy[m] := evalf[digs](integy*(2*m+1)/(b-a)); finalx := finalx+coefsx[m]*subs(x = (2*y-b-a)/(b-a), P(m, x)); finaly := finaly+coefsy[m]*subs(x = (2*y-b-a)/(b-a), P(m, x)) end do; RMS := 0; maxer := 0; for i from a to b do RMS := RMS+(points[i, 1]-evalf(subs(y = i, finalx)))^2+(points[i, 2]-evalf(subs(y = i, finaly)))^2; maxer := max(maxer, points[i, 1]-evalf(subs(y = i, finalx)), points[i, 2]-evalf(subs(y = i, finaly))) end do; RMS := round(sqrt(RMS/(b-a+1))); if `or`(points[b+1, 1] = 0, points[b+2, 1] = 0) then finalxin := 0; finalyin := 0; for mvn from 0 to 20 do integxin := 0; integyin := 0; for k from a to b-1 do fxa := points[k, 1]; fxb := points[k+1, 1]; fya := points[k, 2]; fyb := points[k+1, 2]; integxin := integxin+round(evalf(int((fxa+(fxb-fxa)*(x-k)/(k+1-k))*subs(y = (2*x-b-a)/(b-a), P(mvn, y)), x = k .. k+1))); integyin := integyin+round(evalf(int((fya+(fyb-fya)*(x-k)/(k+1-k))*subs(y = (2*x-b-a)/(b-a), P(mvn, y)), x = k .. k+1))) end do; coefsxin[mvn] := evalf[digs](integxin*(2*mvn+1)/(b-a)); coefsyin[mvn] := evalf[digs](integyin*(2*mvn+1)/(b-a)); finalxin := finalxin+coefsxin[mvn]*subs(x = (2*y-b-a)/(b-a), P(mvn, x)); finalyin := finalyin+coefsyin[mvn]*subs(x = (2*y-b-a)/(b-a), P(mvn, x)); RMS := 0; maxer := 0; for i from a to b do RMS := RMS+(points[i, 1]-evalf(subs(y = i, finalxin)))^2+(points[i, 2]-evalf(subs(y = i, finalyin)))^2; maxer := max(maxer, points[i, 2]-evalf(subs(y = i, finalyin)), points[i, 1]-evalf(subs(y = i, finalxin))) end do; RMS := round(sqrt(RMS/(b-a+1))); if `and`(RMS < curerror, maxer < maxerlim) then totalcoefs := totalcoefs+mvn+1; totalpoints := totalpoints+b; RMS := 0; maxer := 0; mvn := 21; for we from a to min(b, nops(points)-1) do points := subsop(1 = NULL, points) end do; b := a+inter; if nops(points) > 2 then if points[1, 1] = 0 then subsop(1 = NULL, points); points := subsop(1 = NULL, points) else if points[2, 1] = 0 then points := subsop(1 = NULL, points); points := subsop(1 = NULL, points) end if end if end if end if end do else if `or`(RMS >= curerror, maxer >= maxerlim) then totalcoefs := totalcoefs+d+1; totalpoints := totalpoints+b; for we from a to min(b, nops(points)-1) do points := subsop(1 = NULL, points) end do; b := a+inter else b := b+inter end if end if end do; print("RMS", RMS, "maxer", maxer, "totalpoints", totalpoints, "totalcoefs", totalcoefs, "size of coefs", digs, "dimension", d, "RATE", evalf[3](totalcoefs*digs/totalpoints)) end do end do;









