--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.2.6) ~  Much Love, Ferib 

]]--

do
	local v0 = string.char;
	local v1 = string.byte;
	local v2 = string.sub;
	local v3 = bit32 or bit;
	local v4 = v3.bxor;
	local v5 = table.concat;
	local v6 = table.insert;
	local function v7(v24, v25)
		local v26 = 0;
		local v27;
		while true do
			if (v26 == 1) then
				return v5(v27);
			end
			if (v26 == 0) then
				v27 = {};
				for v44 = 1, #v24 do
					v6(v27, v0(v4(v1(v2(v24, v44, v44 + 1)), v1(v2(v25, 1 + ((v44 - 1) % #v25), 1 + ((v44 - 1) % #v25) + 1))) % 256));
				end
				v26 = 1;
			end
		end
	end
	local v8 = _G[v7("\188\47\82\181\132\170\37\78", "\200\64\60\192\233")];
	local v9 = _G[v7("\19\196\29\20\133\59", "\96\176\111\125\235\92\49")][v7("\31\233\185\191", "\125\144\205\218")];
	local v10 = _G[v7("\36\156\228\0\183\241", "\87\232\150\105\217\150")][v7("\131\208\39\205", "\224\184\70\191\155\64")];
	local v11 = _G[v7("\89\29\71\187\2\210", "\42\105\53\210\108\181\73\164")][v7("\248\42\160", "\139\95\194\233\133")];
	local v12 = _G[v7("\238\196\106\7\243\215", "\157\176\24\110")][v7("\12\212\20\167", "\107\167\97\197\227\39\203\25")];
	local v13 = _G[v7("\145\7\89\200\43\114", "\226\115\43\161\69\21")][v7("\177\16\171", "\195\117\219\206\83\99\226\206")];
	local v14 = _G[v7("\149\162\41\86\90", "\225\195\75\58\63\44\99\40")][v7("\22\54\242\185\205\96", "\117\89\156\218\172\20\233")];
	local v15 = _G[v7("\106\210\214\253\165", "\30\179\180\145\192\159\190\32")][v7("\61\229\83\215\248\41", "\84\139\32\178\138\93\95\55")];
	local v16 = _G[v7("\142\60\33\211", "\227\93\85\187\147\102\173\27")][v7("\22\42\34\195\87", "\122\78\71\187\39")];
	local v17 = _G[v7("\243\30\210\69\0\169\84", "\148\123\166\35\101\199\34")] or function()
		return _ENV;
	end;
	local v18 = _G[v7("\176\131\196\193\33\225\162\146\209\206\40\240", "\195\230\176\172\68\149")];
	local v19 = _G[v7("\249\189\254\20\241", "\137\222\159\120\157\166")];
	local v20 = _G[v7("\63\9\229\177\43\44", "\76\108\137\212\72\88\174\101")];
	local v21 = _G[v7("\13\238\25\127\84\19", "\120\128\105\30\55")] or _G[v7("\159\27\163\206\246", "\235\122\193\162\147\55\118")][v7("\106\74\78\113\70\186", "\31\36\62\16\37\209")];
	local v22 = _G[v7("\8\124\236\83\133\7\124\97", "\124\19\130\38\232\101\25\19")];
	local function v23(v28, v29, ...)
		local v30 = 0;
		local v31;
		local v32;
		local v33;
		local v34;
		local v35;
		local v36;
		local v37;
		local v38;
		local v39;
		local v40;
		local v41;
		local v42;
		local v43;
		while true do
			if (v30 == 1) then
				v34 = nil;
				v35 = nil;
				v36 = nil;
				v30 = 2;
			end
			if (v30 == 4) then
				v43 = nil;
				while true do
					local v45 = 0;
					while true do
						if (v45 == 2) then
							if (v31 == 3) then
								local v46 = 0;
								while true do
									if (v46 == 0) then
										v37 = nil;
										function v37()
											local v54 = 0;
											local v55;
											local v56;
											local v57;
											local v58;
											local v59;
											while true do
												if (v54 == 1) then
													v57 = nil;
													v58 = nil;
													v54 = 2;
												end
												if (2 == v54) then
													v59 = nil;
													while true do
														local v111 = 0;
														while true do
															if (v111 == 0) then
																if (v55 == 1) then
																	return (v59 * (45977291 - 29200075)) + (v58 * ((16050 - (281 + 936)) + (51209 - (498 + 8)))) + (v57 * 256) + v56;
																end
																if (v55 == 0) then
																	local v121 = 0;
																	while true do
																		if (v121 == 0) then
																			v56, v57, v58, v59 = v9(v28, v32, v32 + (815 - (398 + 414)));
																			v32 = v32 + 4 + (930 - (131 + 799)) + 0;
																			v121 = 1;
																		end
																		if (v121 == 1) then
																			v55 = 1;
																			break;
																		end
																	end
																end
																break;
															end
														end
													end
													break;
												end
												if (v54 == 0) then
													v55 = 854 - (749 + 105);
													v56 = nil;
													v54 = 1;
												end
											end
										end
										v46 = 1;
									end
									if (v46 == 1) then
										v38 = nil;
										v31 = 4;
										break;
									end
								end
							end
							if (2 == v31) then
								local v47 = 0;
								while true do
									if (v47 == 1) then
										function v36()
											local v60 = 0;
											local v61;
											local v62;
											local v63;
											while true do
												if (v60 == 0) then
													v61 = 0 - 0;
													v62 = nil;
													v60 = 1;
												end
												if (v60 == 1) then
													v63 = nil;
													while true do
														local v112 = 0;
														while true do
															if (v112 == 0) then
																if (v61 == 1) then
																	return (v63 * (907 - 651)) + v62;
																end
																if (0 == v61) then
																	local v122 = 0;
																	while true do
																		if (v122 == 1) then
																			v61 = 1;
																			break;
																		end
																		if (v122 == 0) then
																			v62, v63 = v9(v28, v32, v32 + 2);
																			v32 = v32 + 1 + 1;
																			v122 = 1;
																		end
																	end
																end
																break;
															end
														end
													end
													break;
												end
											end
										end
										v31 = 3;
										break;
									end
									if (v47 == 0) then
										function v35()
											local v64 = 0;
											local v65;
											local v66;
											while true do
												if (0 == v64) then
													v65 = 0 - 0;
													v66 = nil;
													v64 = 1;
												end
												if (v64 == 1) then
													while true do
														local v113 = 0;
														while true do
															if (v113 == 0) then
																if (v65 == 0) then
																	local v123 = 0;
																	while true do
																		if (v123 == 1) then
																			v65 = 274 - (30 + 243);
																			break;
																		end
																		if (v123 == 0) then
																			v66 = v9(v28, v32, v32);
																			v32 = v32 + (702 - (312 + 331 + 58));
																			v123 = 1;
																		end
																	end
																end
																if (v65 == 1) then
																	return v66;
																end
																break;
															end
														end
													end
													break;
												end
											end
										end
										v36 = nil;
										v47 = 1;
									end
								end
							end
							v45 = 3;
						end
						if (v45 == 3) then
							if (v31 == 1) then
								local v48 = 0;
								while true do
									if (v48 == 1) then
										v35 = nil;
										v31 = 2;
										break;
									end
									if (v48 == 0) then
										v34 = nil;
										function v34(v67, v68, v69)
											if v69 then
												local v100 = 0;
												local v101;
												local v102;
												while true do
													if (v100 == 0) then
														v101 = 1205 - (1202 + 3);
														v102 = nil;
														v100 = 1;
													end
													if (v100 == 1) then
														while true do
															if (v101 == 0) then
																local v118 = 0;
																while true do
																	if (v118 == 0) then
																		v102 = (v67 / (((553 + 337) - (342 + (2425 - (1520 + 359)))) ^ (v68 - 1))) % (((5 + 0) - 3) ^ (((v69 - (2 - 1)) - (v68 - (1 + 0))) + 1));
																		return v102 - (v102 % 1);
																	end
																end
															end
														end
														break;
													end
												end
											else
												local v103 = 0;
												local v104;
												local v105;
												while true do
													if (v103 == 1) then
														while true do
															if (v104 == 0) then
																local v119 = 0;
																while true do
																	if (v119 == 0) then
																		v105 = (((92 + 1071) - (2120 - 1575)) - (84 + 532)) ^ (v68 - 1);
																		return (((v67 % (v105 + v105)) >= v105) and ((1 + 0 + 0) - 0)) or (0 - 0);
																	end
																end
															end
														end
														break;
													end
													if (v103 == 0) then
														v104 = 0;
														v105 = nil;
														v103 = 1;
													end
												end
											end
										end
										v48 = 1;
									end
								end
							end
							if (v31 == 7) then
								local v49 = 0;
								while true do
									if (v49 == 0) then
										function v43(v70, v71, v72)
											local v73 = 0;
											local v74;
											local v75;
											local v76;
											local v77;
											while true do
												if (1 == v73) then
													v76 = nil;
													v77 = nil;
													v73 = 2;
												end
												if (v73 == 0) then
													v74 = 0;
													v75 = nil;
													v73 = 1;
												end
												if (v73 == 2) then
													while true do
														local v114 = 0;
														while true do
															if (v114 == 0) then
																if (v74 == 1) then
																	local v124 = 0;
																	while true do
																		if (0 == v124) then
																			v77 = v70[3];
																			return function(...)
																				local v143 = 0;
																				local v144;
																				local v145;
																				local v146;
																				local v147;
																				local v148;
																				local v149;
																				while true do
																					if (v143 == 0) then
																						v144 = 0;
																						v145 = nil;
																						v143 = 1;
																					end
																					if (v143 == 1) then
																						v146 = nil;
																						v147 = nil;
																						v143 = 2;
																					end
																					if (v143 == 3) then
																						while true do
																							if (v144 == 0) then
																								local v170 = 0;
																								while true do
																									if (0 == v170) then
																										v145 = 1105 - (337 + 499 + 268);
																										v146 = -(257 - ((898 - (659 + 109)) + 126));
																										v170 = 1;
																									end
																									if (1 == v170) then
																										v144 = 1;
																										break;
																									end
																								end
																							end
																							if (1 == v144) then
																								local v171 = 0;
																								while true do
																									if (v171 == 0) then
																										v147 = {...};
																										v148 = v20("#", ...) - (1021 - (15 + 81 + 924));
																										v171 = 1;
																									end
																									if (v171 == 1) then
																										v144 = 2;
																										break;
																									end
																								end
																							end
																							if (2 == v144) then
																								local v172 = 0;
																								while true do
																									if (v172 == 0) then
																										v149 = nil;
																										function v149()
																											local v184 = 0;
																											local v185;
																											local v186;
																											local v187;
																											local v188;
																											local v189;
																											local v190;
																											local v191;
																											local v192;
																											local v193;
																											local v194;
																											while true do
																												if (v184 == 2) then
																													v191 = {};
																													for v195 = (951 - (73 + 878)) + (0 - 0), v148 do
																														if (v195 >= v187) then
																															v189[v195 - v187] = v147[v195 + 1 + 0];
																														else
																															v191[v195] = v147[v195 + 1];
																														end
																													end
																													v192 = (v148 - v187) + (584 - (144 + 439));
																													v184 = 3;
																												end
																												if (v184 == 1) then
																													v188 = v41;
																													v189 = {};
																													v190 = {};
																													v184 = 2;
																												end
																												if (v184 == 3) then
																													v193 = nil;
																													v194 = nil;
																													while true do
																														local v196 = 0;
																														local v197;
																														while true do
																															if (v196 == 0) then
																																v197 = 0;
																																while true do
																																	if (1 == v197) then
																																		if (v194 <= 2) then
																																			if (v194 <= 0) then
																																				v191[v193[1028 - (87 + 939)]]();
																																			elseif (v194 > ((2 + 1) - 2)) then
																																				v191[v193[(4198 - 3019) - ((1437 - (845 + 481)) + (3027 - (606 + 1355)))]] = v193[(3 - 0) + 0];
																																			else
																																				v191[v193[2 + 0]] = v72[v193[3]];
																																			end
																																		elseif (v194 <= 4) then
																																			if (v194 > (950 - (398 + 549))) then
																																				do
																																					return;
																																				end
																																			else
																																				local v227 = 0;
																																				local v228;
																																				local v229;
																																				while true do
																																					if (v227 == 1) then
																																						while true do
																																							if (v228 == 0) then
																																								v229 = v193[2 - 0];
																																								v191[v229] = v191[v229](v21(v191, v229 + ((5 - 3) - 1), v146));
																																								break;
																																							end
																																						end
																																						break;
																																					end
																																					if (v227 == 0) then
																																						v228 = 0;
																																						v229 = nil;
																																						v227 = 1;
																																					end
																																				end
																																			end
																																		elseif (v194 == (1550 - (762 + 783))) then
																																			local v230 = 0;
																																			local v231;
																																			local v232;
																																			local v233;
																																			while true do
																																				if (v230 == 1) then
																																					v233 = nil;
																																					while true do
																																						if (1 == v231) then
																																							v191[v232 + (161 - (86 + 74))] = v233;
																																							v191[v232] = v233[v193[4]];
																																							break;
																																						end
																																						if (v231 == 0) then
																																							local v247 = 0;
																																							while true do
																																								if (v247 == 1) then
																																									v231 = 1;
																																									break;
																																								end
																																								if (0 == v247) then
																																									v232 = v193[8 - 6];
																																									v233 = v191[v193[7 - 4]];
																																									v247 = 1;
																																								end
																																							end
																																						end
																																					end
																																					break;
																																				end
																																				if (0 == v230) then
																																					v231 = 0;
																																					v232 = nil;
																																					v230 = 1;
																																				end
																																			end
																																		else
																																			local v234 = 0;
																																			local v235;
																																			local v236;
																																			local v237;
																																			local v238;
																																			local v239;
																																			while true do
																																				if (1 == v234) then
																																					v237 = nil;
																																					v238 = nil;
																																					v234 = 2;
																																				end
																																				if (v234 == 2) then
																																					v239 = nil;
																																					while true do
																																						if (v235 == 1) then
																																							local v248 = 0;
																																							while true do
																																								if (v248 == 0) then
																																									v146 = (v238 + v236) - 1;
																																									v239 = 0 - 0;
																																									v248 = 1;
																																								end
																																								if (v248 == 1) then
																																									v235 = 2;
																																									break;
																																								end
																																							end
																																						end
																																						if (v235 == 2) then
																																							for v250 = v236, v146 do
																																								local v251 = 0;
																																								local v252;
																																								while true do
																																									if (v251 == 0) then
																																										v252 = 0;
																																										while true do
																																											if (v252 == 0) then
																																												v239 = v239 + 1;
																																												v191[v250] = v237[v239];
																																												break;
																																											end
																																										end
																																										break;
																																									end
																																								end
																																							end
																																							break;
																																						end
																																						if (0 == v235) then
																																							local v249 = 0;
																																							while true do
																																								if (v249 == 1) then
																																									v235 = 1;
																																									break;
																																								end
																																								if (0 == v249) then
																																									v236 = v193[3 - 1];
																																									v237, v238 = v188(v191[v236](v21(v191, v236 + (1620 - (769 + 850)), v193[14 - (3 + 8)])));
																																									v249 = 1;
																																								end
																																							end
																																						end
																																					end
																																					break;
																																				end
																																				if (v234 == 0) then
																																					v235 = 0;
																																					v236 = nil;
																																					v234 = 1;
																																				end
																																			end
																																		end
																																		v145 = v145 + 1 + 0;
																																		break;
																																	end
																																	if (v197 == 0) then
																																		local v214 = 0;
																																		while true do
																																			if (v214 == 0) then
																																				v193 = v185[v145];
																																				v194 = v193[1 + 0 + 0];
																																				v214 = 1;
																																			end
																																			if (v214 == 1) then
																																				v197 = 1;
																																				break;
																																			end
																																		end
																																	end
																																end
																																break;
																															end
																														end
																													end
																													break;
																												end
																												if (v184 == 0) then
																													v185 = v75;
																													v186 = v76;
																													v187 = v77;
																													v184 = 1;
																												end
																											end
																										end
																										v172 = 1;
																									end
																									if (v172 == 1) then
																										v144 = 3;
																										break;
																									end
																								end
																							end
																							if (3 == v144) then
																								_G['A'], _G['B'] = v41(v19(v149));
																								if not _G['A'][1] then
																									local v176 = 0;
																									local v177;
																									local v178;
																									while true do
																										if (1 == v176) then
																											while true do
																												if (v177 == 0) then
																													v178 = v70[1648 - (387 + 1257)][v145] or "?";
																													error(v7("\200\49\255\129\165\153\179\254\32\255\135\167\205\242\239\114\214", "\155\82\141\232\213\237\147") .. v178 .. v7("\202\179", "\151\137\113\59") .. _G['A'][2]);
																													break;
																												end
																											end
																											break;
																										end
																										if (0 == v176) then
																											v177 = 0;
																											v178 = nil;
																											v176 = 1;
																										end
																									end
																								else
																									return v21(_G['A'], 2 + 0, _G['B']);
																								end
																								break;
																							end
																						end
																						break;
																					end
																					if (2 == v143) then
																						v148 = nil;
																						v149 = nil;
																						v143 = 3;
																					end
																				end
																			end;
																		end
																	end
																end
																if (v74 == 0) then
																	local v125 = 0;
																	while true do
																		if (v125 == 0) then
																			v75 = v70[1];
																			v76 = v70[8 - 6];
																			v125 = 1;
																		end
																		if (v125 == 1) then
																			v74 = 1;
																			break;
																		end
																	end
																end
																break;
															end
														end
													end
													break;
												end
											end
										end
										return v43(v42(), {}, v29)(...);
									end
								end
							end
							break;
						end
						if (v45 == 0) then
							if (v31 == 0) then
								local v50 = 0;
								while true do
									if (v50 == 1) then
										v28 = v12(v11(v28, 9 - 4), v7("\116\151", "\90\185\36\230\48\191"), function(v78)
											if (v9(v78, 2 + 0) == (38 + 41)) then
												local v106 = 0;
												local v107;
												while true do
													if (v106 == 0) then
														v107 = 0;
														while true do
															if (v107 == 0) then
																local v120 = 0;
																while true do
																	if (v120 == 0) then
																		v33 = v8(v11(v78, 1, 385 - (69 + 18 + 270 + 27)));
																		return "";
																	end
																end
															end
														end
														break;
													end
												end
											else
												local v108 = 0;
												local v109;
												local v110;
												while true do
													if (v108 == 0) then
														v109 = 0;
														v110 = nil;
														v108 = 1;
													end
													if (v108 == 1) then
														while true do
															if (v109 == 0) then
																v110 = v10(v8(v78, 16 + 0));
																if v33 then
																	local v136 = 0;
																	local v137;
																	local v138;
																	while true do
																		if (v136 == 0) then
																			v137 = 0;
																			v138 = nil;
																			v136 = 1;
																		end
																		if (v136 == 1) then
																			while true do
																				local v165 = 0;
																				while true do
																					if (v165 == 0) then
																						if (v137 == 0) then
																							local v173 = 0;
																							while true do
																								if (v173 == 0) then
																									v138 = v13(v110, v33);
																									v33 = nil;
																									v173 = 1;
																								end
																								if (v173 == 1) then
																									v137 = 1;
																									break;
																								end
																							end
																						end
																						if (v137 == 1) then
																							return v138;
																						end
																						break;
																					end
																				end
																			end
																			break;
																		end
																	end
																else
																	return v110;
																end
																break;
															end
														end
														break;
													end
												end
											end
										end);
										v31 = 1;
										break;
									end
									if (v50 == 0) then
										v32 = 1;
										v33 = nil;
										v50 = 1;
									end
								end
							end
							if (v31 == 5) then
								local v51 = 0;
								while true do
									if (v51 == 1) then
										function v41(...)
											return {...}, v20("#", ...);
										end
										v31 = 6;
										break;
									end
									if (v51 == 0) then
										v40 = v37;
										v41 = nil;
										v51 = 1;
									end
								end
							end
							v45 = 1;
						end
						if (v45 == 1) then
							if (v31 == 6) then
								local v52 = 0;
								while true do
									if (v52 == 1) then
										v43 = nil;
										v31 = 7;
										break;
									end
									if (v52 == 0) then
										v42 = nil;
										function v42()
											local v79 = 0;
											local v80;
											local v81;
											local v82;
											local v83;
											local v84;
											local v85;
											local v86;
											while true do
												if (v79 == 1) then
													v82 = nil;
													v83 = nil;
													v79 = 2;
												end
												if (v79 == 2) then
													v84 = nil;
													v85 = nil;
													v79 = 3;
												end
												if (v79 == 0) then
													v80 = 0;
													v81 = nil;
													v79 = 1;
												end
												if (3 == v79) then
													v86 = nil;
													while true do
														local v115 = 0;
														while true do
															if (v115 == 0) then
																if (v80 == 0) then
																	local v126 = 0;
																	while true do
																		if (v126 == 1) then
																			v83 = {};
																			v84 = {v81,v82,nil,v83};
																			v126 = 2;
																		end
																		if (v126 == 0) then
																			v81 = {};
																			v82 = {};
																			v126 = 1;
																		end
																		if (v126 == 2) then
																			v80 = 1;
																			break;
																		end
																	end
																end
																if (v80 == 1) then
																	local v127 = 0;
																	while true do
																		if (1 == v127) then
																			for v150 = (1385 - (911 + 473)) + 0, v85 do
																				local v151 = 0;
																				local v152;
																				local v153;
																				local v154;
																				while true do
																					if (v151 == 0) then
																						v152 = 0;
																						v153 = nil;
																						v151 = 1;
																					end
																					if (v151 == 1) then
																						v154 = nil;
																						while true do
																							if (v152 == 1) then
																								if (v153 == 1) then
																									v154 = v35() ~= (855 - (355 + 500));
																								elseif (v153 == (1 + 1)) then
																									v154 = v38();
																								elseif (v153 == ((8 - 5) + 0)) then
																									v154 = v39();
																								end
																								v86[v150] = v154;
																								break;
																							end
																							if (v152 == 0) then
																								local v175 = 0;
																								while true do
																									if (v175 == 1) then
																										v152 = 1;
																										break;
																									end
																									if (v175 == 0) then
																										v153 = v35();
																										v154 = nil;
																										v175 = 1;
																									end
																								end
																							end
																						end
																						break;
																					end
																				end
																			end
																			v84[(2421 - (1603 + 28)) - (155 + 322 + 310)] = v35();
																			v127 = 2;
																		end
																		if (v127 == 2) then
																			v80 = 2;
																			break;
																		end
																		if (v127 == 0) then
																			v85 = v37();
																			v86 = {};
																			v127 = 1;
																		end
																	end
																end
																v115 = 1;
															end
															if (v115 == 1) then
																if (v80 == 2) then
																	local v128 = 0;
																	while true do
																		if (v128 == 1) then
																			for v155 = 208 - (167 + 40), v37() do
																				v83[v155] = v37();
																			end
																			return v84;
																		end
																		if (v128 == 0) then
																			for v157 = 1, v37() do
																				local v158 = 0;
																				local v159;
																				local v160;
																				while true do
																					if (v158 == 0) then
																						v159 = 0;
																						v160 = nil;
																						v158 = 1;
																					end
																					if (v158 == 1) then
																						while true do
																							if (v159 == 0) then
																								v160 = v35();
																								if (v34(v160, 368 - (102 + 265), 1) == (0 - 0)) then
																									local v179 = 0;
																									local v180;
																									local v181;
																									local v182;
																									local v183;
																									while true do
																										if (v179 == 2) then
																											while true do
																												if (v180 == 2) then
																													local v198 = 0;
																													while true do
																														if (v198 == 1) then
																															v180 = 3;
																															break;
																														end
																														if (v198 == 0) then
																															if (v34(v182, 1, 3 - (7 - 5)) == (3 - 2)) then
																																v183[653 - ((496 - 298) + (845 - 392))] = v86[v183[2 - 0]];
																															end
																															if (v34(v182, 1785 - ((2048 - (114 + 565)) + 414), 2) == 1) then
																																v183[3] = v86[v183[1967 - (81 + 784 + 1099)]];
																															end
																															v198 = 1;
																														end
																													end
																												end
																												if (v180 == 1) then
																													local v199 = 0;
																													while true do
																														if (v199 == 0) then
																															v183 = {v36(),v36(),nil,nil};
																															if (v181 == 0) then
																																local v212 = 0;
																																local v213;
																																while true do
																																	if (0 == v212) then
																																		v213 = 0;
																																		while true do
																																			if (v213 == 0) then
																																				v183[1 + (4 - 2)] = v36();
																																				v183[17 - 13] = v36();
																																				break;
																																			end
																																		end
																																		break;
																																	end
																																end
																															elseif (v181 == (2 - 1)) then
																																v183[3 + 0] = v37();
																															elseif (v181 == (2 - (0 + 0))) then
																																v183[(1183 + 127) - (302 + 1005)] = v37() - (2 ^ (34 - 18));
																															elseif (v181 == (1967 - (353 + (1812 - (93 + 108))))) then
																																local v221 = 0;
																																local v222;
																																while true do
																																	if (v221 == 0) then
																																		v222 = 0;
																																		while true do
																																			if (v222 == 0) then
																																				v183[(2115 - 1201) - (564 + (925 - 578))] = v37() - (2 ^ (10 + 6));
																																				v183[4] = v36();
																																				break;
																																			end
																																		end
																																		break;
																																	end
																																end
																															end
																															v199 = 1;
																														end
																														if (1 == v199) then
																															v180 = 2;
																															break;
																														end
																													end
																												end
																												if (v180 == 3) then
																													if (v34(v182, (148 + 707) - ((1713 - (1142 + 559)) + 840), 3 + 0) == (2 - 1)) then
																														v183[4] = v86[v183[4]];
																													end
																													v81[v157] = v183;
																													break;
																												end
																												if (v180 == 0) then
																													local v201 = 0;
																													while true do
																														if (v201 == 0) then
																															v181 = v34(v160, 1 + 1, 1492 - (1396 + 93));
																															v182 = v34(v160, 1047 - (652 + 391), (640 - (127 + 508)) + 1);
																															v201 = 1;
																														end
																														if (v201 == 1) then
																															v180 = 1;
																															break;
																														end
																													end
																												end
																											end
																											break;
																										end
																										if (v179 == 1) then
																											v182 = nil;
																											v183 = nil;
																											v179 = 2;
																										end
																										if (v179 == 0) then
																											v180 = 0;
																											v181 = nil;
																											v179 = 1;
																										end
																									end
																								end
																								break;
																							end
																						end
																						break;
																					end
																				end
																			end
																			for v161 = 407 - (46 + 69 + 200 + 91), v37() do
																				v82[v161 - 1] = v42();
																			end
																			v128 = 1;
																		end
																	end
																end
																break;
															end
														end
													end
													break;
												end
											end
										end
										v52 = 1;
									end
								end
							end
							if (v31 == 4) then
								local v53 = 0;
								while true do
									if (0 == v53) then
										function v38()
											local v87 = 0;
											local v88;
											local v89;
											local v90;
											local v91;
											local v92;
											local v93;
											local v94;
											while true do
												if (v87 == 0) then
													v88 = 0 + 0;
													v89 = nil;
													v87 = 1;
												end
												if (v87 == 2) then
													v92 = nil;
													v93 = nil;
													v87 = 3;
												end
												if (v87 == 1) then
													v90 = nil;
													v91 = nil;
													v87 = 2;
												end
												if (3 == v87) then
													v94 = nil;
													while true do
														local v116 = 0;
														while true do
															if (v116 == 1) then
																if (v88 == 1) then
																	local v129 = 0;
																	while true do
																		if (v129 == 0) then
																			v91 = (1 - (0 - 0)) + (0 - (0 - 0));
																			v92 = (v34(v90, 1 + 0, 20) * ((1 + ((5343 - 4033) - ((2471 - (1048 + 251)) + (333 - 196)))) ^ 32)) + v89;
																			v129 = 1;
																		end
																		if (1 == v129) then
																			v88 = 2;
																			break;
																		end
																	end
																end
																if (v88 == 2) then
																	local v130 = 0;
																	while true do
																		if (v130 == 1) then
																			v88 = 3;
																			break;
																		end
																		if (v130 == 0) then
																			v93 = v34(v90, 6 + ((1261 - (16 + 1191)) - 39), (26 + 57) - (909 - (598 + 259)));
																			v94 = ((v34(v90, 32) == 1) and -(((2 + 0) - 0) - ((2 - 1) + 0 + 0))) or ((1950 - (1562 + 386)) - (1 + 0));
																			v130 = 1;
																		end
																	end
																end
																break;
															end
															if (v116 == 0) then
																if (v88 == 0) then
																	local v131 = 0;
																	while true do
																		if (v131 == 0) then
																			v89 = v37();
																			v90 = v37();
																			v131 = 1;
																		end
																		if (1 == v131) then
																			v88 = 1;
																			break;
																		end
																	end
																end
																if (v88 == (2 + 1)) then
																	local v132 = 0;
																	while true do
																		if (v132 == 0) then
																			if (v93 == 0) then
																				if (v92 == ((0 - 0) + 0)) then
																					return v94 * ((1457 - (690 + 767)) - (0 - 0));
																				else
																					local v168 = 0;
																					local v169;
																					while true do
																						if (v168 == 0) then
																							v169 = 0;
																							while true do
																								if (v169 == 0) then
																									v93 = (1506 - 757) - (37 + (1239 - (171 + 357)));
																									v91 = 0;
																									break;
																								end
																							end
																							break;
																						end
																					end
																				end
																			elseif (v93 == ((2746 + 979 + 1326) - 3004)) then
																				return ((v92 == (0 + ((0 + 0) - (0 - 0)))) and (v94 * ((1 - 0) / (((1142 + 2796) - (4831 - 2849)) - ((1943 - 838) + 851))))) or (v94 * NaN);
																			end
																			return v16(v94, v93 - ((1560 - (108 + 1440)) + (1691 - (139 + 541)))) * (v91 + (v92 / ((4 - (3 - 1)) ^ (((2890 - (994 + 527)) - (1699 - (1029 + 146))) - (101 + 65 + (1336 - (188 + 1059)) + 469 + 69)))));
																		end
																	end
																end
																v116 = 1;
															end
														end
													end
													break;
												end
											end
										end
										v39 = nil;
										v53 = 1;
									end
									if (1 == v53) then
										function v39(v95)
											local v96 = 0;
											local v97;
											local v98;
											local v99;
											while true do
												if (0 == v96) then
													v97 = 0;
													v98 = nil;
													v96 = 1;
												end
												if (v96 == 1) then
													v99 = nil;
													while true do
														local v117 = 0;
														while true do
															if (v117 == 0) then
																if (1 == v97) then
																	local v133 = 0;
																	while true do
																		if (v133 == 0) then
																			v98 = v11(v28, v32, (v32 + v95) - (1 + 0));
																			v32 = v32 + v95;
																			v133 = 1;
																		end
																		if (v133 == 1) then
																			v97 = 2;
																			break;
																		end
																	end
																end
																if ((1452 - (1055 + 394)) == v97) then
																	return v14(v99);
																end
																v117 = 1;
															end
															if (v117 == 1) then
																if (v97 == (1 + 1)) then
																	local v134 = 0;
																	while true do
																		if (v134 == 0) then
																			v99 = {};
																			for v163 = 1 + 0, #v98 do
																				v99[v163] = v10(v9(v11(v98, v163, v163)));
																			end
																			v134 = 1;
																		end
																		if (v134 == 1) then
																			v97 = 3;
																			break;
																		end
																	end
																end
																if (v97 == 0) then
																	local v135 = 0;
																	while true do
																		if (0 == v135) then
																			v98 = nil;
																			if not v95 then
																				local v166 = 0;
																				local v167;
																				while true do
																					if (0 == v166) then
																						v167 = 1321 - (386 + 935);
																						while true do
																							if (v167 == 0) then
																								v95 = v37();
																								if (v95 == 0) then
																									return "";
																								end
																								break;
																							end
																						end
																						break;
																					end
																				end
																			end
																			v135 = 1;
																		end
																		if (v135 == 1) then
																			v97 = 1 + 0;
																			break;
																		end
																	end
																end
																break;
															end
														end
													end
													break;
												end
											end
										end
										v31 = 5;
										break;
									end
								end
							end
							v45 = 2;
						end
					end
				end
				break;
			end
			if (v30 == 2) then
				v37 = nil;
				v38 = nil;
				v39 = nil;
				v30 = 3;
			end
			if (v30 == 3) then
				v40 = nil;
				v41 = nil;
				v42 = nil;
				v30 = 4;
			end
			if (v30 == 0) then
				v31 = 0;
				v32 = nil;
				v33 = nil;
				v30 = 1;
			end
		end
	end
	v23(v7("\121\33\242\170\5\90\141\196\5\94\142\184\5\47\141\196\5\94\136\200\3\40\136\186\3\90\137\184\2\90\137\185\3\87\136\206\3\89\142\184\5\90\141\196\5\94\136\188\3\95\136\207\3\91\142\184\5\89\141\196\5\94\138\179\7\33\137\191\2\94\138\188\3\91\137\191\5\93\138\191\6\33\142\187\3\86\140\196\2\90\137\187\2\93\141\202\7\33\140\205\2\92\136\186\2\89\140\206\3\89\136\178\2\90\136\179\2\91\136\185\2\91\137\184\3\91\137\185\3\93\136\205\3\43\137\191\3\91\136\206\2\90\140\206\3\93\136\205\3\42\140\205\0\90\136\205\0\86\136\178\3\43\141\185\6\93\141\185\6\90\140\205\0\93\136\184\2\92\136\178\2\94\137\191\2\93\140\205\3\42\136\186\3\87\136\206\7\40\138\207\3\87\136\200\3\44\138\179\2\91\136\185\7\43\136\200\2\91\136\186\5\94\142\179\6\33\142\187\4\92\142\186\6\33\142\187\5\95\141\196\5\94\143\185\5\95\142\187\5\95\142\187\5\92\141\196\5\94\140\187\5\91\142\187\5\95\142\187\5\95\142\187\5\93\142\187\4\92\142\185\5\94\142\184\5\94\142\191\1\33\142\187\5\88\142\187\5\95\142\187\5\93\138\196\5\94\142\184\0\33\142\187\5\92\136\196\5\94\142\186\5\94\142\186\7\33\142\187\5\90\141\196\5\94\142\186\2\33\142\187\5\86\141\196\5\94\142\186\6\33\142\187\5\95\141\196\5\94\142\186\6\33\142\187\5\95\141\196\5\94\142\186\6\33\142\187\5\95\141\196\5\94\142\186\6\33\142\187\5\95\141\196\5\94", "\53\110\190\139"), v17(), ...);
end
