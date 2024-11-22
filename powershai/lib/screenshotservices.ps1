Add-type -Assembly System.Drawing;

#thanks to https://stackoverflow.com/questions/76395669/how-to-get-set-current-window-position-on-screen-in-powershll
function Script:Get-PowershaiWindowsInfo {
	Try { 
		[Void][Window]
	} Catch {
		Add-Type '
		using System;
		using System.Runtime.InteropServices;
		
		[Flags]	
		public enum DwmWindowAttribute : uint
		{
			NCRenderingEnabled = 1,
			NCRenderingPolicy,
			TransitionsForceDisabled,
			AllowNCPaint,
			CaptionButtonBounds,
			NonClientRtlLayout,
			ForceIconicRepresentation,
			Flip3DPolicy,
			ExtendedFrameBounds,
			HasIconicBitmap,
			DisallowPeek,
			ExcludedFromPeek,
			Cloak,
			Cloaked,
			FreezeRepresentation,
			PassiveUpdateMode,
			UseHostBackdropBrush,
			UseImmersiveDarkMode = 20,
			WindowCornerPreference = 33,
			BorderColor,
			CaptionColor,
			TextColor,
			VisibleFrameBorderThickness,
			SystemBackdropType,
			Last
		}
			
		public class Window {
			[DllImport("kernel32.dll")]
			public static extern IntPtr GetConsoleWindow();
			
			[DllImport("user32.dll")]
			[return: MarshalAs(UnmanagedType.Bool)]
			public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
			
			[DllImport("user32.dll")]
			[return: MarshalAs(UnmanagedType.Bool)]
			public static extern bool MoveWindow(IntPtr handle, int x, int y, int width, int height, bool redraw);
			
			[DllImport("user32.dll")]
			[return: MarshalAs(UnmanagedType.Bool)]
			public static extern bool ShowWindow(IntPtr handle, int state);
			
			[DllImport("dwmapi.dll")]
			public static extern int DwmSetWindowAttribute(IntPtr hwnd, DwmWindowAttribute attr, ref int attrValue, int attrSize);

			public static void DisableTransitions(IntPtr Handle)
			{
				int value = 0x01;
				DwmSetWindowAttribute(Handle, DwmWindowAttribute.TransitionsForceDisabled, ref value, Marshal.SizeOf(typeof(int)));
			}
	
		}
		
		public struct RECT {
			public int Left;   // x position of upper-left corner
			public int Top;    // y position of upper-left corner
			public int Right;  // x position of lower-right corner
			public int Bottom; // y position of lower-right corner
		}
	'
	}
	
	$WinHost = Get-WmiObject Win32_Process -Filter ProcessId=$pid;
	$Max=100;
	while($Max-- -and $WinHost.ParentProcessId){
		$WinHost = Get-WmiObject Win32_Process -Filter ProcessId=$($WinHost.ParentProcessId)
		
		if($WinHost.ProcessName -eq "WindowsTerminal.exe"){
			break;
		} 
	}
	
	if($Max -le 0 -or !$WinHost){
		$WinHandle = [Window]::GetConsoleWindow();
	} else {
		$WinHostProcess = Get-Process -Id $WinHost.ProcessId
		$WinHandle = $WinHostProcess.MainWindowHandle;
	}
    
	
	
	$R   = New-Object RECT                                          # Define A Rectangle Object
	[void][Window]::GetWindowRect($WinHandle,[ref]$R)               # Get the Rectangle Object in $R (and Result flag)
	
	
	[PsCustomObject]@{
		rect 	= $r
		width	= $r.right - $r.left
		height 	= $r.bottom - $r.top
		left 	= $r.left 
		top		= $r.top
		hide 	= { 
			[Window]::DisableTransitions($WinHandle);
			[Window]::ShowWindow($WinHandle,0) 
		}.GetNewClosure()
		show 	= { [Window]::ShowWindow($WinHandle,5) }.GetNewClosure()
	}
}

#from: https://stackoverflow.com/questions/2969321/how-can-i-do-a-screen-capture-in-windows-powershell
function Script:Get-PowershaiAreaPrint([Drawing.Rectangle]$bounds, $path) {
   $bmp = New-Object Drawing.Bitmap $bounds.width, $bounds.height
   $graphics = [Drawing.Graphics]::FromImage($bmp)
   
   $graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)
   
   $bmp.Save($path)
   
   $graphics.Dispose()
   $bmp.Dispose()
}

function Global:Get-PowershaiPrintSCreen {
	param($prompt)
	
	$WinInfo = Get-PowershaiWindowsInfo;
	$PrintArea = [Drawing.Rectangle]::FromLTRB($WinInfo.rect.left, $WinInfo.rect.top,  $WinInfo.rect.right,  $WinInfo.rect.bottom)

	$TempFile = [Io.Path]::GetTempFileName() + ".png";

	$null = & $WinInfo.hide
	try {
		Get-PowershaiAreaPrint $PrintArea $TempFile;
	} finally {
		$null = & $WinInfo.show
	}
	
	return $TempFile;
}
