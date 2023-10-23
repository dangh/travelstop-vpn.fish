function travelstop-vpn -e fish_prompt
  set -l proxy HTTPS_PROXY=http://localhost:8888
  set -l need_proxy

  switch (/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk '/ SSID:/ {print $2}')
  case \*wego\*
    set -a need_proxy no
  case \*
    set -a need_proxy yes
  end

  switch "$AWS_PROFILE"
  case \*@PROD
    set -a need_proxy yes
  case \*
    set -a need_proxy no
  end

  if contains yes $need_proxy
    if not contains $proxy $ts_env
      set -a ts_env $proxy
    end
  else
    if set -l index (contains -i $proxy $ts_env)
      set -e ts_env[$index]
    end
  end
end
